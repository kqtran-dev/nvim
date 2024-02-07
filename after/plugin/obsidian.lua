local utils = require("core.utils")

vim.opt.wrap = true

vim.keymap.set('n', 'pf', 'builtin.ObsidianSearch<CR>', {noremap = true, silent = true})

if utils.os_name == "Windows_NT" then
    vim.api.nvim_set_keymap('n', 'gf', ':ObsidianFollowLink<CR>', {noremap = true, silent = true})
end

vim.api.nvim_set_keymap('n', '<leader>po', ':ObsidianSearch<CR>', {noremap = true, silent = true})
