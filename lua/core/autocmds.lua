local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
local api = vim.api

autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

vim.api.nvim_set_hl(0, "YankClipboard", { fg = "black", bg = "LightBlue", bold = true })
vim.api.nvim_set_hl(0, "YankNormal", { fg = "black", bg = "white", bold = true })

-- Automatically copy to Windows clipboard using OSC52
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    require('osc52').copy_register('+')
  end,
})

-- autocmd("TextYankPost", {
--     callback = function()
--         local event = vim.v.event
--         if event.regname == "+" or event.regname == "*" then
--             -- Yanked to system clipboard
--             vim.highlight.on_yank({
--                 higroup = "YankClipboard",
--                 timeout = 190,
--             })
--         else
--             -- Regular yank
--             vim.highlight.on_yank({
--                 higroup = "YankNormal",
--                 timeout = 40,
--             })
--         end
--     end,
-- })
-- don't autocomment new lines

autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("set fo-=c fo-=r fo-=o")
  end,
})

--------------------------------
-- Filetype specific autocmds
--------------------------------

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*.md",
  command = "update",
})

-----------------------------------------------------------
-- Terminal settings
-----------------------------------------------------------

-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
end)
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     -- print(Python filetype detected")
--     -- print("FT:", vim.bo.filetype)
--     -- print("Snacks terminal shell:", vim.inspect(require("snacks").config.terminal.shell))
--   end,
-- })
