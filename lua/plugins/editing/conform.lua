return {
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sql = { "sqlfluff" },
    },
    format_on_save = function(bufnr)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("docker%-compose.*%.yml") then
        return nil
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters = {
      stylua = {
        command = "stylua",
        args = {
          "--config-path",
          vim.fn.expand("~/.config/formatters/stylua.toml"),
          "-",
        },
        stdin = true,
      },
      sqlfluff = {
        command = "sqlfluff",
        args = {
          "fix",
          "-",
          "--disable-progress-bar",
          "--config",
          vim.fn.expand("~/.config/formatters/sqlfluff.ini"),
        },
        stdin = true,
        require_cwd = false,
      },
    },
  },
}

