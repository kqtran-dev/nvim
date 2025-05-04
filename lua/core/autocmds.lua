autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- highlight the yanked text - qol
autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
	vim.defer_fn(function()
  	vim.api.nvim_set_hl(0, "YankClipboard", { fg = "black", bg = "LightBlue", bold = true })
  	vim.api.nvim_set_hl(0, "YankNormal", { fg = "black", bg = "white", bold = true })
  	autocmd("TextYankPost", {
    	callback = function()
      	local event = vim.v.event
      	vim.highlight.on_yank({
        	higroup = (event.regname == "+" or event.regname == "*") and "YankClipboard" or "YankNormal",
        	timeout = (event.regname == "+" or event.regname == "*") and 190 or 40,
      	})
    	end,
  	})
	end, 200) -- delay in milliseconds
  end,
})

-- disable autocomment new lines
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

autocmd("InsertLeave", {
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

--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     -- print(Python filetype detected")
--     -- print("FT:", vim.bo.filetype)
--     -- print("Snacks terminal shell:", vim.inspect(require("snacks").config.terminal.shell))
--   end,
-- })


-----------------------------------------------------------
-- SQL Settings
-----------------------------------------------------------
autocmd("BufWritePre", {
  pattern = "*.sql",
    callback = function()
    vim.cmd([[%!sql-formatter --uppercase --noColor]])
    vim.cmd([[silent! %s/,\s*/\r,/g]])
    end,
})
