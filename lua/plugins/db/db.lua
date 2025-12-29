-- lua/plugins/dadbod.lua
return {
  -- Core DB driver
  { "tpope/vim-dadbod", lazy = true }, -- :contentReference[oaicite:3]{index=3}

  -- UI (tree, saved queries, result buffers, etc.)
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dbui"
    end,
    keys = {
      { "<leader>du", "<cmd>DBUIToggle<cr>", desc = "DB: Toggle UI (Dadbod UI)" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "DB: Find DB buffer (Dadbod UI)" },
      { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "DB: Add connection (Dadbod UI)" },
    },
  },

  -- Autocomplete source (tables/columns cached) :contentReference[oaicite:4]{index=4}
  { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },

  -- Explorer (fuzzy pick objects/actions; we add MSSQL adapter below) :contentReference[oaicite:5]{index=5}
  {
    "tkopets/dadbod-explorer.nvim",
    dependencies = {
      "tpope/vim-dadbod",
      -- gives a nice fuzzy UI for selecting objects/actions
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = { "DadbodExplorer" },
    config = function()
      -- telescope-ui-select setup (safe even if already configured elsewhere)
      pcall(function()
        require("telescope").setup({
          extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown({}) } },
        })
        require("telescope").load_extension("ui-select")
      end)

      local de = require("dadbod-explorer")
      de.setup({
        -- these mappings are from the plugin README :contentReference[oaicite:6]{index=6}
        mappings = {
          n = {
            ["<leader>de"] = "explore",
            ["<leader>do"] = "list_objects",
            ["<leader>dd"] = "describe",
            ["<leader>ds"] = "show_sample",
            ["<leader>dw"] = "show_filter",
            ["<leader>dy"] = "yank_columns",
            ["<leader>dv"] = "show_distribution",
          },
        },
      })

      -- Register MSSQL adapter + extra “SSMS-ish” actions for both mysql/mssql
      require("dadbod_mssql_adapter").register()
      require("dadbod_explorer_extras").register()
    end,
    keys = {
      { "<leader>de", function() require("dadbod-explorer").explore() end, desc = "DB: Explorer (fuzzy)" },
      { "<leader>do", function() require("dadbod-explorer").action("list_objects")() end, desc = "DB: List objects (fuzzy)" },
      { "<leader>dy", function() require("dadbod-explorer").action("yank_columns")() end, desc = "DB: Yank columns" },
    },
  },

  -- nvim-cmp hookup (only needed if you use nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    opts = function(_, opts)
      opts = opts or {}
      opts.sources = opts.sources or {}

      -- Add dadbod completion source (kept low priority vs LSP for code buffers)
      table.insert(opts.sources, { name = "vim-dadbod-completion" })

      return opts
    end,
  },
}
