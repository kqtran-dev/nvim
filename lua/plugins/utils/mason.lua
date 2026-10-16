return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        config = function()
            require("mason").setup()

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Lua / Neovim configuration files
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
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
                        hint = {
                            enable = true,
                        },
                    },
                },
            })

            -- Python
            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoImportCompletions = true,
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                        procMacro = {
                            enable = true,
                        },
                        inlayHints = {
                            bindingModeHints = {
                                enable = true,
                            },
                            closingBraceHints = {
                                enable = true,
                                minLines = 10,
                            },
                            closureReturnTypeHints = {
                                enable = "with_block",
                            },
                            lifetimeElisionHints = {
                                enable = "skip_trivial",
                            },
                        },
                    },
                },
            })

            -- JSON, including common schema support
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
                settings = {
                    json = {
                        validate = {
                            enable = true,
                        },
                        format = {
                            enable = true,
                        },
                    },
                },
            })

            -- PowerShell
            -- Explicitly configured because it requires its Mason bundle path.
            vim.lsp.config("powershell_es", {
                capabilities = capabilities,
                bundle_path = vim.fn.stdpath("data")
                .. "/mason/packages/powershell-editor-services",
                shell = "pwsh",
                init_options = {
                    enableProfileLoading = false,
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
                -- automatic_enable = {
                --     -- exclude = {
                --     --     "powershell_es",
                --     -- },
                -- },
            })
        end,
    },
}

