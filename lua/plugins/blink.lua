vim.pack.add({
  {src = 'https://github.com/Saghen/blink.cmp',
    version = vim.version.range('*'),
  },
  {src = 'https://github.com/fang2hou/blink-copilot'},
  {src = 'https://github.com/rafamadriz/friendly-snippets'},
})

require('blink.cmp').setup({
  appearance = {
    highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
    kind_icons = {
      Copilot = "",
      Text = '󰉿',
      Method = '󰊕',
      Function = '󰊕',
      Constructor = '󰒓',
      Field = '󰜢',
      Variable = '󰆦',
      Property = '󰖷',
      Class = '󱡠',
      Interface = '󱡠',
      Struct = '󱡠',
      Module = '󰅩',
      Unit = '󰪚',
      Value = '󰦨',
      Enum = '󰦨',
      EnumMember = '󰦨',
      Keyword = '󰻾',
      Constant = '󰏿',
      Snippet = '󱄽',
      Color = '󰏘',
      File = '󰈔',
      Reference = '󰬲',
      Folder = '󰉋',
      Event = '󱐋',
      Operator = '󰪚',
      TypeParameter = '󰬛',
    },
  },
  fuzzy = { implementation = "lua"},
  completion = {
    -- trigger = {
    --   enabled = true,
    --   show_on_keyword = true,
    --   show_on_insert = true,
    -- },
    menu = {
      border = 'rounded',
      draw = {
        align_to = 'cursor',
        columns = {
          { "kind_icon", }, { "label", "label_description", gap = 1, "kind" },
        },
        gap = 1,
        padding = 1,
        treesitter = {
          'lsp'
        },
      },
      enabled = true,
      winblend = 0,
      winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      scrollbar = true,
    },
    ghost_text = {
      enabled = true
    },
  },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'cmdline',
      -- removing this because for some reason the autocompletions show at the top of the file and it is very annoying
      'buffer',
      'copilot'},
    providers = {
      copilot = {
        enabled = true,
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
        opts = {
          max_completions = 3,
        }
      },
    },
  },
});
