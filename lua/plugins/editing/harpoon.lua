return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        -- add file
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Add file to Harpoon list" })
        -- snacks picker integration
        local function toggle_snacks_picker(harpoon_files)
            local items = {}
            for i, item in ipairs(harpoon_files.items) do
                table.insert(items, {
                    label = string.format("%d. %s", i, vim.fn.fnamemodify(item.value, ":t")),
                    file = item.value,
                })
            end
            require("snacks").picker({
                title = "Harpoon",
                items = items,
                on_select = function(entry)
                    if entry and entry.file then
                        vim.cmd("edit " .. vim.fn.fnameescape(entry.file))
                    end
                end,
            })
        end
        -- open Harpoon picker
        set("n", "<C-h>", function()
            toggle_snacks_picker(harpoon:list())
        end, { desc = "Open Harpoon menu (Snacks picker)" })

        -- direct slot navigation
        for i = 1, 4 do
            set("n", "<leader>" .. i, function()
                harpoon:list():select(i)
            end, { desc = "Go to Harpoon file " .. i })
        end
    end,
}

