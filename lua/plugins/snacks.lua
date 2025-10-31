vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

require("nvim-treesitter.configs").setup({
  input = { enabled = true },
  picker = {
    lsp = {
      unavailable = "",
      enabled = " ",
      disabled = " ",
      attached = "󰖩 "
    },
  },
  statuscolumn = { enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
      open = true, -- show open fold icons
      git_hl = true, -- use Git Signs hl for fold icons
    },
    git = {
      -- patterns to match Git signs
      patterns = { "GitSign", "MiniDiffSign" },
    },
    refresh = 50, -- refresh at most every 50ms
  },
  words = { enabled = true },
  styles = {
    notification = {
      -- wo = { wrap = true } -- Wrap notifications
    }
  }}
)


-- Keymaps (converted from lazy spec)
local map = vim.keymap.set
local S = require('snacks')

-- Top Pickers & Explorer
map('n', '<leader><space>', function() S.picker.smart() end, { desc = 'Smart Find Files' })
map('n', '<leader>,',      function() S.picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>/',      function() S.picker.grep() end, { desc = 'Grep' })
map('n', '<leader>:',      function() S.picker.command_history() end, { desc = 'Command History' })
map('n', '<leader>n',      function() S.picker.notifications() end, { desc = 'Notification History' })
map('n', '<leader>e',      function() S.explorer() end, { desc = 'File Explorer' })

-- find
map('n', '<leader>fb', function() S.picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>fc', function() S.picker.files({ cwd = vim.fn.stdpath('config') }) end, { desc = 'Find Config File' })
map('n', '<leader>ff', function() S.picker.files() end, { desc = 'Find Files' })
map('n', '<leader>fg', function() S.picker.git_files() end, { desc = 'Find Git Files' })
map('n', '<leader>fp', function() S.picker.projects() end, { desc = 'Projects' })
map('n', '<leader>fr', function() S.picker.recent() end, { desc = 'Recent' })

-- git
map('n', '<leader>gb', function() S.picker.git_branches() end, { desc = 'Git Branches' })
map('n', '<leader>gl', function() S.picker.git_log() end, { desc = 'Git Log' })
map('n', '<leader>gL', function() S.picker.git_log_line() end, { desc = 'Git Log Line' })
map('n', '<leader>gs', function() S.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>gS', function() S.picker.git_stash() end, { desc = 'Git Stash' })
map('n', '<leader>gd', function() S.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
map('n', '<leader>gf', function() S.picker.git_log_file() end, { desc = 'Git Log File' })

-- Grep
map('n', '<leader>sb', function() S.picker.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>sB', function() S.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
map('n', '<leader>sg', function() S.picker.grep() end, { desc = 'Grep' })
map({ 'n', 'x' }, '<leader>sw', function() S.picker.grep_word() end, { desc = 'Visual selection or word' })

-- search
map('n', [[<leader>s"]], function() S.picker.registers() end, { desc = 'Registers' })
map('n', '<leader>s/',  function() S.picker.search_history() end, { desc = 'Search History' })
map('n', '<leader>sa',  function() S.picker.autocmds() end, { desc = 'Autocmds' })
map('n', '<leader>sc',  function() S.picker.command_history() end, { desc = 'Command History' })
map('n', '<leader>sC',  function() S.picker.commands() end, { desc = 'Commands' })
map('n', '<leader>sd',  function() S.picker.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<leader>sD',  function() S.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
map('n', '<leader>sh',  function() S.picker.help() end, { desc = 'Help Pages' })
map('n', '<leader>sH',  function() S.picker.highlights() end, { desc = 'Highlights' })
map('n', '<leader>si',  function() S.picker.icons() end, { desc = 'Icons' })
map('n', '<leader>sj',  function() S.picker.jumps() end, { desc = 'Jumps' })
map('n', '<leader>sk',  function() S.picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>sl',  function() S.picker.loclist() end, { desc = 'Location List' })
map('n', '<leader>sm',  function() S.picker.marks() end, { desc = 'Marks' })
map('n', '<leader>sM',  function() S.picker.man() end, { desc = 'Man Pages' })
map('n', '<leader>sp',  function() S.picker.lazy() end, { desc = 'Search for Plugin Spec' })
map('n', '<leader>sq',  function() S.picker.qflist() end, { desc = 'Quickfix List' })
map('n', '<leader>sR',  function() S.picker.resume() end, { desc = 'Resume' })
map('n', '<leader>su',  function() S.picker.undo() end, { desc = 'Undo History' })
map('n', '<leader>uC',  function() S.picker.colorschemes() end, { desc = 'Colorschemes' })

-- LSP
map('n', 'gd', function() S.picker.lsp_definitions() end, { desc = 'Goto Definition' })
map('n', 'gD', function() S.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
map('n', 'gr', function() S.picker.lsp_references() end, { desc = 'References', nowait = true })
map('n', 'gI', function() S.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
map('n', 'gy', function() S.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
map('n', 'gai', function() S.picker.lsp_incoming_calls() end, { desc = 'C[a]lls Incoming' })
map('n', 'gao', function() S.picker.lsp_outgoing_calls() end, { desc = 'C[a]lls Outgoing' })
map('n', '<leader>ss', function() S.picker.lsp_symbols() end, { desc = 'LSP Symbols' })
map('n', '<leader>sS', function() S.picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

-- Other
map('n', '<leader>z',  function() S.zen() end, { desc = 'Toggle Zen Mode' })
map('n', '<leader>Z',  function() S.zen.zoom() end, { desc = 'Toggle Zoom' })
map('n', '<leader>.',  function() S.scratch() end, { desc = 'Toggle Scratch Buffer' })
map('n', '<leader>S',  function() S.scratch.select() end, { desc = 'Select Scratch Buffer' })
map('n', '<leader>n',  function() S.notifier.show_history() end, { desc = 'Notification History' })
map('n', '<leader>bd', function() S.bufdelete() end, { desc = 'Delete Buffer' })
map('n', '<leader>cR', function() S.rename.rename_file() end, { desc = 'Rename File' })
map({ 'n', 'v' }, '<leader>gB', function() S.gitbrowse() end, { desc = 'Git Browse' })
map('n', '<leader>gg', function() S.lazygit() end, { desc = 'Lazygit' })
map('n', '<leader>un', function() S.notifier.hide() end, { desc = 'Dismiss All Notifications' })
map('n', '<c-/>',      function() S.terminal() end, { desc = 'Toggle Terminal' })
map('n', '<c-_>',      function() S.terminal() end, { desc = 'which_key_ignore' })
map({ 'n', 't' }, ']]', function() S.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
map({ 'n', 't' }, '[[', function() S.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })

