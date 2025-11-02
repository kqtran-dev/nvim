require("core.set")
require("core.globals")
require("core.remap")
require("core.utils")
require("core.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- This is also a good place to setup other settings (vim.opt)

g.mapleader = " "
g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins.editing" },
        { import = "plugins.snacks" },
        { import = "plugins.ui" },
        { import = "plugins.utils" },
        { import = "plugins.db" },
    },
    checker = { enabled = true },
})
