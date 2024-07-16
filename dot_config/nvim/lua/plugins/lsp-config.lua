return {
	-- LSP manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pylsp",
					"rust_analyzer",
					"ruff",
					"marksman",
					"harper_ls",
					"ruff_lsp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- Set different settings for different languages' LSP
			-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
			--     - the settings table is sent to the LSP
			--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
			local lspconfig = require("lspconfig")

			-- Customized on_attach function
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			local opts = function(desc)
				return { desc = desc, noremap = true, silent = true }
			end
			vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, opts("Open diagnostics popup"))
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
			vim.keymap.set(
				"n",
				"<leader>dq",
				vim.diagnostic.setloclist,
				opts("Add buffer diagnostics to the location list.")
			)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			---@diagnostic disable-next-line: unused-local
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = function(desc)
					return { desc = "LSP / " .. desc, noremap = true, silent = true, buffer = bufnr }
				end
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Show hover information"))
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Show implentations"))
				vim.keymap.set("n", "H", vim.lsp.buf.signature_help, bufopts("Show signature help"))
				vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts("Add workspace folder"))
				vim.keymap.set(
					"n",
					"<Leader>wr",
					vim.lsp.buf.remove_workspace_folder,
					bufopts("Remove workspace folder")
				)
				vim.keymap.set("n", "<Leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts("Show all workspace folders"))
				vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts("Rename globally"))
				vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts("Show code actions"))
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Show references"))
				-- vim.keymap.set("n", "<Leader>f", function()
				-- 	vim.lsp.buf.format({ async = true })
				-- end, bufopts("Format buffer"))
			end

			-- Configure each language
			-- How to add LSP for a specific language?
			-- 1. Use `:Mason` to install corresponding LSP
			-- 2. Add configuration below
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "lua" },
			})
			lspconfig.pylsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = {},
								maxLineLength = 120,
							},
						},
					},
				},
			})
			lspconfig.ruff.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
			})
			lspconfig.ruff_lsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
			})
			lspconfig.marksman.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "markdown" },
			})
			lspconfig.harper_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "toml" },
			})
			lspconfig.gdscript.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "gdscript" },
			})
		end,
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
