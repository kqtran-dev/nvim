-- aliases for commonly used vim functions
_G.g   = vim.g
_G.opt = vim.opt
_G.api = vim.api
_G.cmd = vim.cmd
_G.augroup = vim.api.nvim_create_augroup
_G.autocmd = vim.api.nvim_create_autocmd
_G.set = vim.keymap.set


-- Platform flags
local sysname = vim.loop.os_uname().sysname
_G.IS_MACOS   = sysname == "Darwin"
_G.IS_WINDOWS = sysname:match("Windows")
_G.IS_WSL     = vim.fn.has("wsl") == 1
_G.IS_LINUX   = not (_G.IS_MACOS or _G.IS_WINDOWS)

