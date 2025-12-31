-- Directory  Purpose
-- ftdetect/  Detects filetypes (rules).
-- ftplugin/  Per-filetype options/behavior.
-- syntax/    Syntax highlighting for filetypes.
-- indent/    Indentation rules per filetype.
-- after/ftplugin/  Override/extend plugin or default ftplugin.

-- Shorthands (kept global to avoid breaking required modules)
g        = vim.g
opt      = vim.opt
api      = vim.api
cmd      = vim.cmd
augroup  = vim.api.nvim_create_augroup
autocmd  = vim.api.nvim_create_autocmd
set      = vim.keymap.set
uv       = vim.uv

local hostname = uv.os_gethostname()

-- Disable built-ins/providers you don't use
g.loaded_gzip              = 1
g.loaded_tar               = 1
g.loaded_tarPlugin         = 1
g.loaded_zip               = 1
g.loaded_zipPlugin         = 1
-- g.loaded_netrw          = 1
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
g.skip_defaults_lua        = 1
g.loaded_node_provider     = 0
g.loaded_perl_provider     = 0

-- OS detection
local sysname = vim.loop.os_uname().sysname
local has     = vim.fn.has
local is_wsl  = (has("wsl") == 1) or (vim.env.WSL_INTEROP ~= nil)

g.IS_WSL     = is_wsl
g.IS_MACOS   = (sysname == "Darwin")
g.IS_WINDOWS = (sysname == "Windows_NT")
g.IS_LINUX   = (sysname == "Linux") and not is_wsl

-- Hostname pattern used in your Windows logic
local on_corp_windows = g.IS_WINDOWS and hostname:match("^BWF")
local minimal = hostname:match("^COR089")

-- Environment routing (order matters: WSL before Linux)
if g.IS_WSL then
  g.WSL = 1
  require("core.base_wsl")
elseif g.minimal then
  require("core.base_min")
elseif g.IS_LINUX then
  g.BASE_linux = 1
  require("core.base_linux")
elseif g.IS_MACOS then
  g.BASE_macOS = 1
  require("core.base_macos")
elseif on_corp_windows and not g.vscode then
  g.BASE = 1
  require("core.base")
  -- require("lsp")
elseif on_corp_windows and g.vscode then
  g.VSCODE = 1
  require("core.vscode")
end
