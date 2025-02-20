return {
  'saghen/blink.cmp',
  dependencies = {
    'fang2hou/blink-copilot',
    'rafamadriz/friendly-snippets',
  },
  version = '*',
  opts = {
    completion = {
      ghost_text = {
        enabled = true
      },
      menu = {
        enabled = true,
        border = 'rounded',
        winblend = 15,
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        scrollbar = false,
        draw = {
          columns = {
            { "kind_icon", }, { "label", "label_description", gap = 1, "kind" },
          },
          treesitter = {
            'lsp'
          },
        },
      },
    },
    keymap = {
      preset = 'super-tab',
    },
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

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'cmdline', 'buffer', 'copilot'},
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
        }
      }
    },
    cmdline = {
      enabled = false,
      keymap = nil, -- Inherits from top level `keymap` config when not set
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == '/' or type == '?' then return { 'buffer' } end
        -- Commands
        if type == ':' or type == '@' then return { 'cmdline' } end
        return {}
      end,
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
        },
        menu = {
          auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
          draw = {
            columns = { { 'label', 'label_description', gap = 1 } },
          },
        }
      }
    }
  },
  opts_extend = { "sources.default" } 
}
