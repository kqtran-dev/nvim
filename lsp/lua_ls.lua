return {
    cmd = {
        "lua-language-server",
        "--force-accept-workspace",
    },
    filetypes = {
        "lua",
    },
    root_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h"),
    root_markers = {
        ".git",
        ".luacheckrc",
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "selene.toml",
        "selene.yml",
        "stylua.toml",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                disable = { "missing-parameters", "missing-fields" },
                globals = { 'vim' },
            },
            format = {
                enable = false,
            },
        },
    },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
