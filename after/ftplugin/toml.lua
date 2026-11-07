-- neovim's built-in TOML filetype plugin adds - to iskeyword because hyphens are valid characters in TOML keys
-- this is annoying
vim.opt_local.iskeyword:remove("-")
