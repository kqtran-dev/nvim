local utils = require("core.utils")

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
    vim.g.python3_host_prog = os.getenv("LOCALAPPDATA") .. "Microsoft/WindowsApps/python.exe"
    -- set clipboard stuff
    vim.g.clipboard = {
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
vim.opt.clipboard = "unnamedplus"
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
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
-- set system clipboard

-- obsidian
vim.opt.conceallevel = 0 -- this is super annoying when trying to read json

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

-- not sure what this is for 
--vim.g.loaded_matchparen = 1 
--
--autocmd FileType json setlocal formatprg=jq
-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})
    -- highlights yanked text
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank({
                higroup = "IncSearch",
                timeout = 40,
            })
        end,
    })


local utils = require("core.utils")

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
    vim.g.python3_host_prog = os.getenv("LOCALAPPDATA") .. "Microsoft/WindowsApps/python.exe"
    -- set clipboard stuff
    vim.g.clipboard = {
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
vim.opt.clipboard = "unnamedplus"
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
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
-- set system clipboard

-- obsidian
vim.opt.conceallevel = 0 -- this is super annoying when trying to read json

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

-- not sure what this is for 
--vim.g.loaded_matchparen = 1 
--
--autocmd FileType json setlocal formatprg=jq
-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd('normal! g`"zz')
        end
    end,
})


-- Keep the cursor position when yanking    
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y$"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursorPreYank then
            vim.api.nvim_win_set_cursor(0, cursorPreYank)
        end
    end,
})
