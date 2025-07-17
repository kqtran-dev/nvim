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
    'yaml', 'lua', 'sql'
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
-- autocmd("BufWritePre", {
--   pattern = "*.sql",
--     callback = function()
--     vim.cmd([[%!npx sql-formatter -l tsql]])
--     vim.cmd([[silent! %s/,\s*/\r,/g]])
--     end,
-- })

function SendVisualToTerminal()
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    vim.notify("Not in visual mode", vim.log.levels.WARN)
    return
  end

  -- Yank selection to "v" register
  vim.cmd('normal! "vy')
  local selected = vim.fn.getreg("v")
  if not selected or selected == "" then
    vim.notify("No text selected.", vim.log.levels.WARN)
    return
  end

  local function find_terminal_buf_and_job()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].buftype == "terminal" and vim.api.nvim_buf_is_loaded(buf) then
        local jid = vim.b[buf].terminal_job_id
        if jid and jid > 0 then
          return buf, jid
        end
      end
    end
    return nil, nil
  end

  -- Step 1: Try to find existing terminal
  local term_bufnr, job_id = find_terminal_buf_and_job()

  -- Step 2: If no terminal exists, create one using Snacks.terminal()
  if not term_bufnr then
    pcall(function() Snacks.terminal() end)
    vim.wait(500, function()
      term_bufnr, job_id = find_terminal_buf_and_job()
      return term_bufnr ~= nil
    end, 20, false)

    if not term_bufnr then
      vim.notify("Failed to initialize terminal.", vim.log.levels.ERROR)
      return
    end
  end

  -- Step 3: Ensure terminal is visible
  pcall(function() Snacks.terminal() end)

  -- Step 4: Get the window that now shows the terminal
  local target_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == term_bufnr then
      target_win = win
      break
    end
  end

  local current_win = vim.api.nvim_get_current_win()
  if target_win then
    vim.api.nvim_set_current_win(target_win)
  end

  -- Step 5: Send selected lines
  for line in selected:gmatch("[^\r\n]+") do
    vim.fn.chansend(job_id, line .. "\r")
  end

  -- Step 6: Return to original window
  vim.api.nvim_set_current_win(current_win)
end

-- vim.keymap.set({"n", "v", "i"}, "<C-e>", "<Nop>", { noremap = true })
-- vim.keymap.set("v", "<C-r>", SendVisualToTerminal, { noremap = true, silent = true })
-- vim.keymap.set("v", "<leader>r", SendVisualToTerminal, { noremap = true, silent = true })

