vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- not sure what this functionality was called in Sublime but it's amazing
vim.keymap.set("v", "<C-S-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-S-K>", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-R><C-w>\\>/<C-r><C-w><Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

