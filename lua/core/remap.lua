vim.g.mapleader = " "
-- vim.g.mapleader = ";" -- can't use this because I like ; to be a motion command

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- not sure what this functionality was called in Sublime but it's amazing
-- select visual block, ctrl + shift + arrow to move the block up and down
vim.keymap.set("v", "<C-S-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<C-S-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv")

-- half page jumps - keep cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- cursor centered for search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- deletes highlighted text into void register so you can keep existing register
-- vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
-- vim.keymap.set('n', '<leader>Y', '\"+Y')

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])


-- can't remember what this was f
-- vim.keymap.set("n", "<leader>s", ":%s/\\<<C-R><C-w>\\>/<C-r><C-w><Left><Left><Left>")
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- try to mimic ctrl + backspace behavior // undoing this because C-W is more vim-like
-- vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

vim.keymap.set('n', '<Leader>q', '<C-R><C-R>');
vim.keymap.set('n', '<leader>b', ':ls<CR>:b<Space>', { noremap = true, silent = false })

-- Map gh to move to the beginning of the line
vim.api.nvim_set_keymap('n', 'gh', '^', { noremap = true, silent = true })

-- Map gl to move to the end of the line
vim.api.nvim_set_keymap('n', 'gl', 'g_', { noremap = true, silent = true })

-- tabs - sacrilege
vim.keymap.set("n", "<C-j>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })

-- Copy an entire file to the clipboard
function YankFile()
    vim.cmd("normal! ggVG\"+y")
end

vim.api.nvim_set_keymap('n', '<leader>yA', ':lua YankFile()<CR>', { noremap = true, silent = true })


function YankInsideMarks()
    -- Jump to the starting mark `[`
    vim.cmd("normal! `{v`}\"+y")
    print("Copied text between marks to clipboard")
end

-- Map to a keybinding (e.g., <leader>m)
vim.api.nvim_set_keymap('n', '<leader>yim', ':lua YankInsideMarks()<CR>', { noremap = true, silent = true })

-- insert mode movement
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-h>", "<C-o>b")
vim.keymap.set("i", "<C-l>", "<C-o>w")


-- window movement
vim.keymap.set("n", "<Up>", "<c-w>k")
vim.keymap.set("n", "<Down>", "<c-w>j")
vim.keymap.set("n", "<Left>", "<c-w>h")
vim.keymap.set("n", "<Right>", "<c-w>l")
