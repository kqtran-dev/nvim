-- ~/.config/nvim/lua/rust_run.lua
-- Quick Rust runner + REPL for Neovim.
--   <leader>rr  (normal)  save & run the whole file (cargo run, or rustc for a lone .rs file)
--   <leader>rs  (visual)  send highlighted lines to the evcxr REPL
--   <leader>rs  (normal)  send the current line to the REPL
--   <leader>rk  (normal)  restart the REPL (clears all variables)
-- Requires: Neovim 0.10+, and `cargo install evcxr_repl` for the REPL.

local M = {}

local HEIGHT = 15
local repl = { buf = nil, chan = nil }
local run_buf = nil

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
    vim.notify("evcxr not found. Install it with: cargo install evcxr_repl", vim.log.levels.ERROR)
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
-- Run whole file
---------------------------------------------------------------------------
function M.run_file()
  vim.cmd("silent write")

  local root = vim.fs.root(0, "Cargo.toml")
  local cmd
  if root then
    cmd = "cd " .. vim.fn.shellescape(root) .. " && cargo run -q"
  else
    local exe = vim.fn.tempname()
    cmd = ("rustc --edition 2024 %s -o %s && %s"):format(
      vim.fn.shellescape(vim.fn.expand("%:p")), exe, exe)
  end

  local cur = vim.api.nvim_get_current_win()
  local old = run_buf
  run_buf = vim.api.nvim_create_buf(false, true)

  -- Reuse the previous output window if it's still open
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

  term_start({ vim.o.shell, vim.o.shellcmdflag, cmd })
  vim.cmd("normal! G")
  vim.api.nvim_set_current_win(cur)
end

---------------------------------------------------------------------------
-- Keymaps (only in Rust buffers)
---------------------------------------------------------------------------
function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function(ev)
      local function o(desc) return { buffer = ev.buf, desc = desc } end
      vim.keymap.set("n", "<leader>rr", M.run_file, o("Rust: run file"))
      vim.keymap.set("x", "<leader>rs", M.send_selection, o("Rust: send selection to REPL"))
      vim.keymap.set("n", "<leader>rs", M.send_line, o("Rust: send line to REPL"))
      vim.keymap.set("n", "<leader>rk", M.restart_repl, o("Rust: restart REPL"))
    end,
  })
end

return M
