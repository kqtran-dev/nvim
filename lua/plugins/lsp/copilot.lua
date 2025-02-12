return {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
    -- vim.g.copilot_node_command = "C:\\Program Files\\nodejs\\node"
    require("copilot").setup({})
    end,
}
