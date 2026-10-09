-- ~/.config/nvim/lua/core/term_toggle.lua
--   <leader>~  open the terminal, jump to it if open, or hide it if you're in it
--   <leader>q  kill the terminal session
local M = {}

local HEIGHT = 15
local term_buf = nil

local function alive()
  return term_buf and vim.api.nvim_buf_is_valid(term_buf)
end

-- Window currently showing the terminal, or nil if hidden
local function term_win()
  if not alive() then return nil end
  local win = vim.fn.bufwinid(term_buf)
  return win ~= -1 and win or nil
end

local function start_shell()
  local opts = {
    on_exit = function()
      -- Typing `exit` in the shell cleans up so the next toggle starts fresh
      vim.schedule(function()
        if alive() then vim.api.nvim_buf_delete(term_buf, { force = true }) end
        term_buf = nil
      end)
    end,
  }
  if vim.fn.has("nvim-0.11") == 1 then
    opts.term = true
    vim.fn.jobstart(vim.o.shell, opts)
  else
    vim.fn.termopen(vim.o.shell, opts)
  end
end

function M.toggle()
  local win = term_win()

  -- In the terminal: hide it (the shell keeps running)
  if win and win == vim.api.nvim_get_current_win() then
    vim.cmd("stopinsert")
    if not pcall(vim.api.nvim_win_hide, win) then
      -- It's the only window, so swap in another buffer instead
      pcall(vim.cmd, "bprevious")
    end
    return
  end

  if win then
    -- Open elsewhere: jump to it
    vim.api.nvim_set_current_win(win)
  else
    -- Hidden or never started: open a bottom split
    vim.cmd("botright " .. HEIGHT .. "split")
    if alive() then
      vim.api.nvim_win_set_buf(0, term_buf)
    else
      term_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_win_set_buf(0, term_buf)
      start_shell()
    end
  end
  vim.cmd("startinsert")
end

function M.kill()
  if not alive() then
    vim.notify("No terminal session running")
    return
  end
  vim.api.nvim_buf_delete(term_buf, { force = true }) -- also stops the shell
  term_buf = nil
end

function M.setup()
  vim.keymap.set({ "n", "t" }, "<leader>~", M.toggle, { desc = "Toggle terminal" })
  vim.keymap.set("n", "<leader>q", M.kill, { desc = "Kill terminal" })
end

return M
