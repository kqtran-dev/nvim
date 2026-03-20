-- this should go in `~/.config/nvim/ftplugin/ps1.lua` or inside a `FileType` autocmd
vim.keymap.set("n", "<leader>lt", function() require("powershell").toggle_term() end)
