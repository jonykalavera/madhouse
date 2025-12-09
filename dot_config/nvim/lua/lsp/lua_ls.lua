return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = require("common.handlers").on_attach,
	filetypes = { "lua" },
	cmd = { "lua-language-server" },
}
