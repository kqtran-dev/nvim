g.mapleader = " "

set("n", "<leader>rw", vim.cmd.Ex)

-- not sure what this functionality was called in Sublime but it's amazing
-- select visual block, ctrl + shift + arrow to move the block up and down
-- these work for macOS
set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv")
set("v", "<C-S-J>", ":m '>+1<CR>gv=gv")
set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv")
set("v", "<C-S-K>", ":m '<-2<CR>gv=gv")

--  these are the ones that work on Windows
set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)

set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- half page jumps - keep cursor centered
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")

-- cursor centered for search terms
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- deletes highlighted text into void register so you can keep existing register
-- set('n', '<leader>y', '\"+y')
set('v', '<leader>y', '\"+y')
-- set('n', '<leader>Y', '\"+Y')

set("x", "<leader>p", "\"_dP")

set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

-- can't remember what this was f
-- set("n", "<leader>s", ":%s/\\<<C-R><C-w>\\>/<C-r><C-w><Left><Left><Left>")
-- set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- try to mimic ctrl + backspace behavior // undoing this because C-W is more vim-like
-- vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

set('n', '<Leader>q', '<C-R><C-R>');
set('n', '<leader>b', ':ls<CR>:b<Space>', { noremap = true, silent = false })

-- Map gh to move to the beginning of the line
api.nvim_set_keymap('n', 'gh', '^', { noremap = true, silent = true })

-- Map gl to move to the end of the line
api.nvim_set_keymap('n', 'gl', 'g_', { noremap = true, silent = true })

-- tabs - sacrilege
set("n", "<leader>h", ":tabprevious<CR>", { noremap = true, silent = true })
set("n", "<Leader>l", ":tabnext<CR>", { noremap = true, silent = true })
set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })

-- yank an entire file to the clipboard
function YankAll()
    vim.cmd("normal! ggVG\"+y")
end
api.nvim_set_keymap('n', '<leader>yA', ':lua YankAll()<CR>', { noremap = true, silent = true })

-- yank from mark { to mark }
function YankInsideMarks()
    -- Jump to the starting mark `[`
    vim.cmd("normal! `{v`}\"+y")
    print("Copied text between marks to clipboard")
end
-- Map to a keybinding (e.g., <leader>m)
api.nvim_set_keymap('n', '<leader>yim', ':lua YankInsideMarks()<CR>', { noremap = true, silent = true })

function YankLine()
  vim.cmd('normal! ^v$"+y')
end
api.nvim_set_keymap('n', '<leader>y', ':lua YankLine()<CR>', { noremap = true, silent = true })

-- insert mode movement
set("i", "<C-j>", "<Down>")
set("i", "<C-k>", "<Up>")
set("i", "<C-h>", "<C-o>b")
set("i", "<C-l>", "<C-o>w")


-- window movement
-- set("n", "<Up>", "<c-w>k")
-- set("n", "<Down>", "<c-w>j")
-- set("n", "<Left>", "<c-w>h")
-- set("n", "<Right>", "<c-w>l")

-- vim.keymap.set("n", "zk", function()
--   vim.cmd("normal! zk")
--   while vim.fn.foldclosed('.') ~= -1 do
--     vim.cmd("normal! zk")
--   end
-- end, { noremap = true, silent = true })
--
--
-- vim.keymap.set("n", "zj", function()
--   vim.cmd("normal! zj")
--   while vim.fn.foldclosed('.') ~= -1 do
--     vim.cmd("normal! zj")
--   end
-- end, { noremap = true, silent = true })
--
