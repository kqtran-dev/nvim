return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
    event = "VeryLazy",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "lua_ls",
          "jsonls",
          "powershell_es",
        },
        automatic_enable = true,
      })
    end,
  },
}

