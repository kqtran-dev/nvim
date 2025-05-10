return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')

    telescope.setup({
      defaults = {
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
          prompt_position = 'top',
        },
        -- winblend = 10,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope search files' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope git_files' })
    -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers'})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end,
}

