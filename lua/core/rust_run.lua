-- ~/.config/nvim/lua/rust_run.lua
-- Quick Rust runner, REPL, and Cargo workflow for Neovim.
--
--   Run / REPL
--   <leader>rr  (normal)  save & run the file (cargo run, or rustc for a lone .rs file)
--   <leader>rs  (visual)  send highlighted lines to the evcxr REPL
--   <leader>rs  (normal)  send the current line to the REPL
--   <leader>rk  (normal)  restart the REPL (clears all variables)
--
--   Cargo (inside a Cargo project)
--   <leader>rb  cargo build   -> errors/warnings in the quickfix list
--   <leader>rc  cargo clippy  -> lints + errors in the quickfix list (use this most)
--   <leader>rt  cargo test    -> output in the bottom split
--   <leader>rf  cargo fmt     -> formats the project and reloads open buffers
--
--   Quickfix: ]q / [q (or :cnext / :cprev) jump between problems, :cclose closes it.
--
-- Requires: Neovim 0.10+, `cargo install --locked evcxr_repl` for the REPL,
--           and `rustup component add clippy rustfmt` (installed by default with rustup).

local M = {}

local HEIGHT = 15
local repl = { buf = nil, chan = nil }
local run_buf = nil

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

-- Start a terminal job in the current buffer (handles the 0.11 API change)
local function term_start(cmd, opts)
  opts = opts or {}
  if vim.fn.has("nvim-0.11") == 1 then
    opts.term = true
    return vim.fn.jobstart(cmd, opts)
  end
  return vim.fn.termopen(cmd, opts)
end

-- Show buf in a bottom split, reusing its window if it's already visible
local function show_bottom(buf)
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    vim.cmd("botright " .. HEIGHT .. "split")
    win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
  end
  return win
end

local function scroll_to_end(buf)
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
  end
end

local function cargo_root(quiet)
  local root = vim.fs.root(0, "Cargo.toml")
  if not root and not quiet then
    vim.notify("Not in a Cargo project. Create one with: cargo new my_project",
      vim.log.levels.WARN)
  end
  return root
end

-- If the current file is <root>/src/bin/<name>.rs, return " --bin <name>", else ""
local function bin_flag(root)
  local file = vim.fn.expand("%:p")
  local name = file:match("^" .. vim.pesc(root) .. "/src/bin/([^/]+)%.rs$")
  return name and (" --bin " .. vim.fn.shellescape(name)) or ""
end


-- Run a shell command in the shared bottom output split (replacing the last run)
local function run_in_term(cmd, cwd)
  local cur = vim.api.nvim_get_current_win()
  local old = run_buf
  run_buf = vim.api.nvim_create_buf(false, true)

  local win = (old and vim.api.nvim_buf_is_valid(old)) and vim.fn.bufwinid(old) or -1
  if win ~= -1 then
    vim.api.nvim_set_current_win(win)
    vim.api.nvim_win_set_buf(win, run_buf)
  else
    show_bottom(run_buf)
  end
  if old and vim.api.nvim_buf_is_valid(old) then
    vim.api.nvim_buf_delete(old, { force = true })
  end

  term_start({ vim.o.shell, vim.o.shellcmdflag, cmd }, { cwd = cwd })
  vim.cmd("normal! G")
  vim.api.nvim_set_current_win(cur)
end

---------------------------------------------------------------------------
-- REPL (evcxr)
---------------------------------------------------------------------------
local function ensure_repl()
  local cur = vim.api.nvim_get_current_win()

  if repl.chan and repl.buf and vim.api.nvim_buf_is_valid(repl.buf) then
    show_bottom(repl.buf)
    vim.api.nvim_set_current_win(cur)
    return true
  end

  if vim.fn.executable("evcxr") == 0 then
    vim.notify("evcxr not found. Install it with: cargo install --locked evcxr_repl",
      vim.log.levels.ERROR)
    return false
  end

  repl.buf = vim.api.nvim_create_buf(false, true)
  show_bottom(repl.buf)
  repl.chan = term_start({ "evcxr" }, {
    on_exit = function() repl.chan = nil end,
  })
  vim.api.nvim_set_current_win(cur)
  return true
end

local function send(lines)
  if not ensure_repl() then return end
  vim.fn.chansend(repl.chan, table.concat(lines, "\n") .. "\n")
  vim.defer_fn(function() scroll_to_end(repl.buf) end, 50)
end

function M.send_selection()
  vim.cmd("normal! \27") -- leave visual mode so the '< and '> marks are set
  local s, e = vim.fn.line("'<"), vim.fn.line("'>")
  send(vim.fn.getline(s, e))
end

function M.send_line()
  send({ vim.api.nvim_get_current_line() })
end

function M.restart_repl()
  if repl.chan then vim.fn.jobstop(repl.chan) end
  if repl.buf and vim.api.nvim_buf_is_valid(repl.buf) then
    vim.api.nvim_buf_delete(repl.buf, { force = true })
  end
  repl.buf, repl.chan = nil, nil
  ensure_repl()
end

---------------------------------------------------------------------------
-- Run
---------------------------------------------------------------------------
function M.run_file()
  vim.cmd("silent wall")
  local root = cargo_root(true)
  if root then
    run_in_term("cargo run -q" .. bin_flag(root), root)
  else
    local exe = vim.fn.tempname()
    run_in_term(("rustc --edition 2024 %s -o %s && %s"):format(
      vim.fn.shellescape(vim.fn.expand("%:p")), exe, exe))
  end
end

---------------------------------------------------------------------------
-- Cargo -> quickfix (build / clippy)
---------------------------------------------------------------------------
-- --message-format=short gives one line per problem:
--   src/main.rs:4:9: warning: unused variable: `x`
--   src/main.rs:7:5: error[E0425]: cannot find value `y` in this scope
local EFM = "%f:%l:%c: %t%*[^:]: %m"

local function cargo_qf(subcmd, title)
  local root = cargo_root()
  if not root then return end
  vim.cmd("silent wall")
  vim.notify(title .. "…")

  local cmd = { "cargo", subcmd, "--message-format=short" }
  vim.system(cmd, { cwd = root, text = true }, vim.schedule_wrap(function(res)
    local output = (res.stderr or "") .. (res.stdout or "")
    local problems = {}
    for line in output:gmatch("[^\n]+") do
      if line:match("^[^%s:]+:%d+:%d+: ") then
        -- cargo prints paths relative to the project root; make them absolute
        if not line:match("^/") then line = root .. "/" .. line end
        table.insert(problems, line)
      end
    end

    vim.fn.setqflist({}, " ", { title = title, lines = problems, efm = EFM })

    if #problems > 0 then
      vim.cmd("botright copen")
      vim.cmd("wincmd p")
    else
      vim.cmd("cclose")
    end

    if res.code == 0 then
      local msg = #problems > 0 and (" (%d warning(s))"):format(#problems) or ""
      vim.notify("✓ " .. title .. " passed" .. msg)
    elseif #problems == 0 then
      -- Failed without file:line errors (e.g. a bad Cargo.toml): show the raw output
      vim.notify(title .. " failed:\n" .. output, vim.log.levels.ERROR)
    else
      vim.notify("✗ " .. title .. " failed", vim.log.levels.ERROR)
    end
  end))
end

function M.build()  cargo_qf("build", "cargo build") end
function M.clippy() cargo_qf("clippy", "cargo clippy") end

---------------------------------------------------------------------------
-- Test / fmt
---------------------------------------------------------------------------
function M.test()
  local root = cargo_root()
  if not root then return end
  vim.cmd("silent wall")
  run_in_term("cargo test", root)
    -- --nocapture shows println!/dbg! output from inside tests
  run_in_term("cargo test" .. bin_flag(root) .. " -- --nocapture", root)
end

function M.fmt()
  local root = cargo_root()
  if not root then return end
  vim.cmd("silent wall")
  vim.system({ "cargo", "fmt" }, { cwd = root, text = true }, vim.schedule_wrap(function(res)
    if res.code == 0 then
      vim.cmd("checktime") -- reload buffers changed on disk
      vim.notify("✓ formatted")
    else
      vim.notify("cargo fmt failed:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
    end
  end))
end

---------------------------------------------------------------------------
-- Keymaps (only in Rust buffers)
---------------------------------------------------------------------------
function M.setup()
  -- Lets :checktime reload formatted files without a prompt
  vim.o.autoread = true

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function(ev)
      local function o(desc) return { buffer = ev.buf, desc = desc } end
      vim.keymap.set("n", "<leader>rr", M.run_file, o("Rust: run file"))
      vim.keymap.set("x", "<leader>rs", M.send_selection, o("Rust: send selection to REPL"))
      vim.keymap.set("n", "<leader>rs", M.send_line, o("Rust: send line to REPL"))
      vim.keymap.set("n", "<leader>rk", M.restart_repl, o("Rust: restart REPL"))
      vim.keymap.set("n", "<leader>cb", M.build, o("Rust: cargo build"))
      vim.keymap.set("n", "<leader>cc", M.clippy, o("Rust: cargo clippy"))
      vim.keymap.set("n", "<leader>ct", M.test, o("Rust: cargo test"))
      vim.keymap.set("n", "<leader>cf", M.fmt, o("Rust: cargo fmt"))
    end,
  })
end

return M
