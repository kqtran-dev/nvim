return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sql = { "sleek" },
      python = { "ruff" },
    },
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
      sleek = {
        command = "sleek",
        args = {
          "--indent-spaces=2",
          "--lines-between-queries=4",
        },
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "[F]ormat buffer",
      },
    },
    -- format_on_save = function(bufnr)
    --   local bufname = vim.api.nvim_buf_get_name(bufnr)
    --   if bufname:match("docker%-compose.*%.yml") then
    --     return nil
    --   end
    --   return { timeout_ms = 500, lsp_fallback = true }
    -- end,
  },
}
