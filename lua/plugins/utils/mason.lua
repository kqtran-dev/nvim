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
            "neovim/nvim-lspconfig"
        },
        config = function()
            require("mason").setup()

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
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
                    "rust_analyzer",
                },
                automatic_enable = {
                    exclude = {
                        "powershell_es",
                    },
                },
            })

            local pes_bundle = vim.fn.stdpath("data")
            .. "/mason/packages/powershell-editor-services"

            vim.lsp.config("powershell_es", {
                capabilities = capabilities,
                bundle_path = pes_bundle,
            })

            vim.lsp.enable("powershell_es")
        end,
    },
}

