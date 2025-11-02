return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- Add current file
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon: Add file" })

    -- Default Harpoon picker (Ctrl+e)
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: Quick menu" })

    -- Snacks picker for Harpooned files: <leader> f h
    local function snacks_harpoon_picker(list)
      local items = {}
      for i, item in ipairs(list.items) do
        items[#items + 1] = {
          label = string.format("%d. %s", i, vim.fn.fnamemodify(item.value, ":t")),
          file = item.value,
        }
      end
      require("snacks").picker({
        title = "Harpoon",
        items = items,
        on_select = function(entry)
          if entry and entry.file then
            vim.cmd.edit(vim.fn.fnameescape(entry.file))
          end
        end,
      })
    end

    vim.keymap.set("n", "<leader>fh", function()
      snacks_harpoon_picker(harpoon:list())
    end, { desc = "Find [H]arpooned files (Snacks)" })

    -- Direct slot navigation (explicit, no loop)
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
      { desc = "Harpoon: Go to file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
      { desc = "Harpoon: Go to file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
      { desc = "Harpoon: Go to file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
      { desc = "Harpoon: Go to file 4" })
  end,
}

