local utils = require("core.utils")
local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.nu = true
opt.autochdir = true

------------------------------------------------------------
-- Memory, CPU
----------------------------------------------------------
-- perf
opt.shadafile = "NONE"

-- swapfiles and backup / undo
opt.swapfile = false
opt.backup = false

-- autocomplete
opt.completeopt=noinsert,menuone,noselect
opt.lazyredraw = true       -- Faster scrolling

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.smartindent = true
opt.wrap = false
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- block mode changes
opt.virtualedit = "block"

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Relative line numbers
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80'      -- Line length marker at 80 columns
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
-- search
opt.ignorecase = true       -- Ignore case letters when search
opt.hlsearch = false
opt.incsearch = true
opt.inccommand = "split"
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
opt.signcolumn = "yes"
-----------------------------------------------------------
-- clipboard settings
-----------------------------------------------------------
-- opt.clipboard = "unnamedplus" -- leaving commented - keep OS and vim clipboards separate
-- instead, use hotkeys
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Windows OS
if utils.os_name == "Windows_NT" then
    opt.undodir = os.getenv("LOCALAPPDATA") .. "/.cache/vim/undodir"
    g.python3_host_prog = os.getenv("LOCALAPPDATA") .. "Microsoft/WindowsApps/python.exe"
    -- set clipboard stuff
    g.clipboard = {
        name = 'win32yank',
        copy = {
            ["+"] = 'win32yank.exe -i --crlf',
            ["*"] = 'win32yank.exe -i --crlf',
        }, 
        paste = {
            ["+"] = 'win32yank.exe -o --lf',
            ["*"] = 'win32yank.exe -o --lf',
        },
        cache_enabled = 0,
    }
else
    opt.undodir = os.getenv("HOME") .. "/.cache/vim/undodir"
end

-- WSL
if vim.fn.has('wsl') == 1 then
    g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end
--
-- found on 2025-02-08 - need to test
-- --vim.g.clipboard = {
-- 	name = "xclip-wsl",
-- 	copy = {
-- 		["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
-- 		["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
-- 	},
-- 	paste = {
-- 		["+"] = { "xclip", "-o", "-selection", "clipboard" },
-- 		["*"] = { "xclip", "-o", "-selection", "primary" },
-- 	},
-- 	cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operations
-- }
-- set system clipboard

opt.undofile = true
opt.cursorline = true
opt.updatetime = 50
opt.list = true
opt.scrolloff = 999 -- keep cursor centered
opt.listchars = "tab:⇤–⇥,trail:·,extends:⇢,precedes:⇠,space:·"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.conceallevel = 0 -- this is super annoying when trying to read json

-----------------------------------------------------------
-- netrw
-----------------------------------------------------------
g.netrw_banner = 0
g.netrw_list_hide = '*.swp,.git,.DS_Store,*.o,*.pyc,__pycache__'
g.netrw_hide = 1
-- vim.g.loaded_netrwPlugin = 0
g.netrw_banner = 0

--autocmd FileType json setlocal formatprg=jq
-- Restore cursor to file position in previous editing session
    -- highlights yanked text

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"

-- Disable builtin plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   -- "netrw",
   -- "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
   "tutor",
   "rplugin",
   "synmenu",
   "optwin",
   "compiler",
   "bugreport",
   -- "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
