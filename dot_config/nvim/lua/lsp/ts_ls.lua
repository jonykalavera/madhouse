return {
	on_attach = require("common.handlers").on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
	},
}
