require("core.set")
require("core.globals")
require("core.remap")
require("core.utils")
require("core.autocmds")
require("core.lsp")

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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins.editing.nvim-autopairs" },
        { import = "plugins.editing.blink" },
        -- { import = "plugins.editing.blink-copilot" },
        { import = "plugins.editing.conform" },
        -- { import = "plugins.editing.harpoon" },
        -- { import = "plugins.editing.neotab" },
        { import = "plugins.editing.nvim-treesitter" },
        { import = "plugins.editing.nvim-treesitter-textobjects" },
        { import = "plugins.editing.osc52" },
        { import = "plugins.editing.oscyank" },
        { import = "plugins.editing.vim-surround" },
        { import = "plugins.snacks.picker" },
        -- { import = "plugins.snacks.bigfile" },
        -- { import = "plugins.snacks.dashboard" },
        { import = "plugins.snacks.indent" },
        -- { import = "plugins.snacks.terminal" },
        { import = "plugins.ui.colorscheme" },
        { import = "plugins.ui.neoscroll" },
        { import = "plugins.ui.smear" },
        { import = "plugins.ui.transparent" },
        -- { import = "plugins.utils.mason" },
        { import = "plugins.utils.telescope" },
        -- { import = "plugins.utils.vim-startuptime" },
        { import = "plugins.utils.which-key" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})
