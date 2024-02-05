local utils = require("core.utils")

vim.opt.wrap = true

if utils.os_name == "Windows_NT" then
    vim.api.nvim_set_keymap('n', 'gf', ':ObsidianFollowLink<CR>', {noremap = true, silent = true})
end 


