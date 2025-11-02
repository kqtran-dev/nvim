return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        input = { enabled = true },
        picker = {
            formatters = {
                file = {
                    filename_first = true,
                },
            },
            prompt = " ",
            layout = {
                layout = {
                    backdrop = false,
                },
            },
            lsp = {
                unavailable = "",
                enabled = " ",
                disabled = " ",
                attached = "󰖩 ",
            },
        },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = true, -- show open fold icons
                git_hl = true, -- use Git Signs hl for fold icons
            },
            git = {
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
        },
    },
    keys = {
        -- { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        -- { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        -- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        -- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
        {
            "<leader>sS",
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = "LSP Workspace Symbols",
        },
        -- { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
        {
            "<leader>z",
            function()
                Snacks.zen()
            end,
            desc = "Toggle Zen Mode",
        },
        {
            "<leader>.",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        -- { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
        -- { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
        -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
        -- { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
        -- { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
        -- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
        -- Top Pickers & Explorer
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        -- { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        -- { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
        -- { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
        -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
        -- { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command
                -- Create some toggle mappings
                -- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                -- Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                -- Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                -- Snacks.toggle.diagnostics():map("<leader>ud")
                -- Snacks.toggle.line_number():map("<leader>ul")
                -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                -- Snacks.toggle.treesitter():map("<leader>uT")
                -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                -- Snacks.toggle.inlay_hints():map("<leader>uh")
                -- Snacks.toggle.indent():map("<leader>ug")
            end,
        })
    end,
}
