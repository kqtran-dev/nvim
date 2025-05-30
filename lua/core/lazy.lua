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
  { import = "plugins.ui" }, -- UI plugins (themes, treesitter, devicons)
  { import = "plugins.editing" }, -- lsp and completion
  { import = "plugins.utils" },
  { import = "plugins.snacks" },
  defaults = { lazy = true },
  ui = {
    border = "rounded"
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "editorconfig",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "gzip",
        "spellfile",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
)


