return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      -- Fold settings
      vim.o.foldcolumn = "1" -- Show fold column
      vim.o.foldlevel = 99   -- Start with all folds open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local ufo = require("ufo")

      -- Keymaps for fold manipulation
      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

      -- Option 1: Using coc.nvim as LSP client
      -- Uncomment this if you use coc.nvim
      -- require("ufo").setup()

      -- Option 2: Using built-in LSP for folding
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true
      -- }
      -- local language_servers = vim.lsp.get_clients() -- or manually list servers {'gopls', 'clangd'}
      -- for _, ls in ipairs(language_servers) do
      --   require("lspconfig")[ls].setup({
      --     capabilities = capabilities
      --   })
      -- end

      -- Option 3: Use Treesitter as the main provider
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })

      -- Option 4: Disable all providers (Not recommended)
      -- Uncomment if you want to disable UFO providers
      -- ufo.setup({
      --   provider_selector = function(bufnr, filetype, buftype)
      --     return ''
      --   end
      -- })
    end,
  },
}

