vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
-- perf
vim.opt.shadafile = "NONE"

-- wraps and tabs
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.list = true

vim.opt.listchars = "tab:⇤–⇥,trail:·,extends:⇢,precedes:⇠,space:·"
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- clipboard
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
-- obsidian
vim.opt.conceallevel = 1
