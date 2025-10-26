return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{ -- optional cmp completion source for require statements and module annotations
				"hrsh7th/nvim-cmp",
				opts = function(_, opts)
					opts.sources = opts.sources or {}
					table.insert(opts.sources, {
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					})
				end,
			},
		},
		opts = {
			servers = {
				ansiblels = {},
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Set different settings for different languages' LSP
			-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
			--     - the settings table is sent to the LSP
			--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
			local handlers = require("common.handlers")
			-- Configure each language
			-- How to add LSP for a specific language?
			-- 1. Use `:Mason` to install corresponding LSP
			-- 2. Add configuration below
			vim.lsp.config("lua_ls", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "lua" },
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.config("pylsp", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = {
								ignore = {},
								maxLineLength = 120,
							},
							mypy = { enabled = true },
							pyls_mypy = { enabled = true },
							pyright = { enabled = false },
						},
					},
				},
			})
			vim.lsp.enable("pylsp")
			vim.lsp.config("ruff", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
			})
			vim.lsp.enable("ruff")
			vim.lsp.config("marksman", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "markdown" },
			})
			vim.lsp.enable("marksman")
			vim.lsp.config("harper_ls", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "toml" },
			})
			vim.lsp.enable("harper_ls")
			vim.lsp.config("gdscript", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
				filetypes = { "gdscript" },
			})
			vim.lsp.enable("gdscript")
			vim.lsp.config("eslint", {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
					handlers.on_attach(client, bufnr)
				end,
				capabilities = capabilities,
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
			})
			vim.lsp.enable("eslint")
			vim.lsp.config("ts_ls", {
				on_attach = handlers.on_attach,
				capabilities = capabilities,
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
			})
			vim.lsp.enable("ts_ls")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"marksman",
				"harper_ls",
				"eslint",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
		config = function()
			require("lspkind").init({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
}
