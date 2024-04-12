local utils = require("core.utils")

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
-- perf
vim.opt.shadafile = "NONE"


-- wraps and tabs
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- block mode changes
vim.opt.virtualedit = "block"

-- swapfiles and backup / undo
vim.opt.swapfile = false
vim.opt.backup = false
if utils.os_name == "Windows_NT" then
    vim.opt.undodir = os.getenv("LOCALAPPDATA") .. "/.cache/vim/undodir"
else
    vim.opt.undodir = os.getenv("HOME") .. "/.cache/vim/undodir"
end
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.list = true

vim.opt.splitbelow = true -- split below instead of above
vim.opt.splitright = true -- split below instead of above

vim.opt.scrolloff = 999 -- keep cursor centered

vim.opt.listchars = "tab:⇤–⇥,trail:·,extends:⇢,precedes:⇠,space:·"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- clipboard
--vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
vim.opt.clipboard = ""

-- sync with system clipboard on focus
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  command = [[call setreg("@", getreg("+"))]],
})

-- sync with system clipboard on focus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  pattern = { "*" },
  command = [[call setreg("+", getreg("@"))]], 
})
-- set system clipboard

-- obsidian
vim.opt.conceallevel = 1

vim.api.nvim_create_autocmd("InsertLeave", {
     pattern = "*.md",
     command = "update",
})

-- netrw
vim.g.netrw_banner = 0

vim.g.netrw_list_hide = '*.swp,.git,.DS_Store,*.o,*.pyc,__pycache__'
vim.g.netrw_hide = 1
-- vim.g.loaded_netrwPlugin = 0
vim.g.netrw_banner = 0

vim.keymap.set('n', '<Leader>q', '<C-R><C-R>');
