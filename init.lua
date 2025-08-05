g   = vim.g
opt = vim.opt
api = vim.api
cmd = vim.cmd
augroup = vim.api.nvim_create_augroup
autocmd = vim.api.nvim_create_autocmd
set = vim.keymap.set
uv = vim.uv

g.loaded_gzip              = 1
g.loaded_tar               = 1
g.loaded_tarPlugin         = 1
g.loaded_zip               = 1
g.loaded_zipPlugin         = 1
-- g.loaded_netrw             = 1
g.loaded_netrwPlugin       = 1
g.loaded_netrwSettings     = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchparen        = 1
g.loaded_matchit           = 1
g.loaded_spellfile_plugin  = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_2html_plugin      = 1
g.loaded_shada_plugin      = 1
g.loaded_man               = 1
g.loaded_editorconfig      = 1
g.skip_defaults_lua = 1
g.loaded_node_provider = 0
g.loaded_perl_provider = 0

local sysname = vim.loop.os_uname().sysname

g.IS_MACOS   = sysname == "Darwin"
g.IS_WINDOWS = sysname == "Windows_NT"
g.IS_WSL     = vim.fn.has("wsl") == 1
g.IS_LINUX   = not (_G.IS_MACOS or _G.IS_WINDOWS)


if (uv.os_gethostname() ~= "BWF" and not g.vscode) then
  g.BASE = 1
  require("core.base")
end

if (uv.os_gethostname() ~= "BWF" and g.vscode) then
  g.VSCODE = 1
  require("core.vscode")
end

if (vim.uv.os_gethostname() ~= "BWF" and IS_WSL) then
  vim.WSL = 1
  require("core.wsl")
end

if (IS_MACOS) then
  require("core.macos")
end
