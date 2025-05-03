return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = "VimEnter",
    -- lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        color_overrides = {
          all = {

          },
        },
        custom_highlights = function(C)
          return {
          }
        end,
      }
      vim.cmd [[colorscheme catppuccin-frappe]]
    end,
  },
}
