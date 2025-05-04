return {
  {
    "mfussenegger/nvim-lint",
    enabled = true,
    event = "VeryLazy",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        markdown = { "markdownlint", "vale" },
        yaml = { "yamllint" },
        lua = { "luacheck" },
      }

      -- Run linter on save
      api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })

      -- Only show diagnostics with severity ERROR or higher
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
        signs = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
        underline = {
          severity = { min = vim.diagnostic.severity.ERROR },
        },
      })

      -- Diagnostic float
      vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.open_float(nil, { focus = false })
      end, { desc = "Show diagnostics" })
    end,
  },
}
