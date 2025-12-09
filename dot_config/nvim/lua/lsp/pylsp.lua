return {
	on_attach = require("common.handlers").on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = false },
				pycodestyle = {
					ignore = { "W391", "W503" },
					maxLineLength = 120,
				},
				mypy = { enabled = true },
				pyls_mypy = { enabled = true, live_mode = true },
				pyright = { enabled = false },
			},
		},
	},
}
