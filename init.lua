g   = vim.g
opt = vim.opt
api = vim.api
cmd = vim.cmd
augroup = vim.api.nvim_create_augroup
autocmd = vim.api.nvim_create_autocmd
set = vim.keymap.set
uv = vim.uv

local hostname = uv.os_gethostname()

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
g.IS_WINDOWS = sysname == "Windows_NT"
g.IS_WSL     = vim.fn.has("wsl") == 1
g.IS_LINUX   = sysname == "Linux"

if (g.IS_LINUX) then 
	g.BASE_linux = 1
	require("core.base_linux")
elseif (g.IS_MACOS) then
	g.BASE_macOS = 1
	require("core.base_macos")
elseif (g.IS_WINDOWS and string.match(hostname, "^BWF") and not g.vscode) then
	g.BASE = 1
	require("core.base")
  -- require("lsp")
elseif (g.IS_WINDOWS and string.match(hostname, "^BWF") and g.vscode) then
	g.VSCODE = 1
	require("core.vscode")
elseif (g.IS_WINDOWS and string.match(hostname, "^BWF") and g.IS_WSL) then
	g.WSL = 1
	require("core.wsl")
end
