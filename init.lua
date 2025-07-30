-- vim.g.loaded_gzip              = 1
-- vim.g.loaded_tar               = 1
-- vim.g.loaded_tarPlugin         = 1
-- vim.g.loaded_zip               = 1
-- vim.g.loaded_zipPlugin         = 1
-- vim.g.loaded_netrw             = 1
-- vim.g.loaded_netrwPlugin       = 1
-- vim.g.loaded_netrwSettings     = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- vim.g.loaded_matchparen        = 1
-- vim.g.loaded_matchit           = 1
-- vim.g.loaded_spellfile_plugin  = 1
-- vim.g.loaded_tutor_mode_plugin = 1
-- vim.g.loaded_2html_plugin      = 1
-- vim.g.loaded_shada_plugin      = 1
-- vim.g.loaded_man               = 1
-- vim.g.loaded_editorconfig      = 1
vim.g.skip_defaults_lua = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
if vim.uv.os_gethostname() == "BWF064UGW6YR14" then
    require("core.globals")
    require("core.remap")
    require("core.utils")
    require("core.set")
    require("core.autocmds")
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        { import = "plugins.editing" }, -- UI plugins (themes, treesitter, devicons)
        -- defaults = { lazy = true },
        -- ui = {
        --   border = "rounded"
        -- },
        -- performance = {
        --   cache = {
        --     enabled = true,
        --   },
        --   rtp = {
        --     disabled_plugins = {
        --       "editorconfig",
        --       "matchit",
        --       "matchparen",
        --       "netrwPlugin",
        --       "gzip",
        --       "spellfile",
        --       "tarPlugin",
        --       "tohtml",
        --       "tutor",
        --       "zipPlugin",
        --     },
        --   },
        -- },
    })
else
    require("core")
end
