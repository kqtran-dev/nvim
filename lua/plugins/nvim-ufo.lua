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
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
      end

      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      require('ufo').setup({
        fold_virt_text_handler = handler
      })

      -- buffer scope handler
      -- will override global handler if it is existed
      -- local bufnr = vim.api.nvim_get_current_buf()
      -- require('ufo').setFoldVirtTextHandler(bufnr, handler)

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

