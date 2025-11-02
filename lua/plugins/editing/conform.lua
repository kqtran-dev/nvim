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
        -- format_on_save = function(bufnr)
        --   local bufname = vim.api.nvim_buf_get_name(bufnr)
        --   if bufname:match("docker%-compose.*%.yml") then
        --     return nil
        --   end
        --   return { timeout_ms = 500, lsp_fallback = true }
        -- end,
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
        end, { range = true }),
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
}
