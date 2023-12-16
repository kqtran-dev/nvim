local lsp = require('lsp-zero')
require'lspconfig'.pyright.setup{}
lsp.preset('recommended')
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)
lsp.setup()


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = { }
})
