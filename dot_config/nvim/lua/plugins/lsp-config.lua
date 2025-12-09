return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					-- Virtual text display priority
					-- Higher values appear above other plugins (e.g., Git-Blame)
					virt_texts = {
						priority = 12048,
					},
				},
			})
			vim.diagnostic.config({ virtual_text = true })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on Lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load `luvit` types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{ -- Optional `cmp` completion source for require statements and module annotations
				"hrsh7th/nvim-cmp",
				opts = function(_, opts)
					opts.sources = opts.sources or {}
					table.insert(opts.sources, {
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading `LuaLS` completions
					})
				end,
			},
		},
		config = function()
			-- Set different settings for different languages' LSP.
			-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
			-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
			--     - the settings table is sent to the LSP
			--     - on_attach: a Lua callback function to run after LSP attaches to a given buffer
			-- Configure each language
			-- How to add LSP for a specific language?
			-- 1. Add configuration at `lua/lsp/<lang>.lua`
			-- 2. Use `:Mason` to install corresponding LSP
			require("lsp")

			-- deduplicate LSP references
			local function filterDuplicates(array)
				local uniqueArray = {}
				for _, tableA in ipairs(array) do
					local isDuplicate = false
					for _, tableB in ipairs(uniqueArray) do
						if vim.deep_equal(tableA, tableB) then
							isDuplicate = true
							break
						end
					end
					if not isDuplicate then
						table.insert(uniqueArray, tableA)
					end
				end
				return uniqueArray
			end

			local function on_list(options)
				options.items = filterDuplicates(options.items)
				vim.fn.setqflist({}, " ", options)
				vim.cmd("botright copen")
			end

			-- Usage
			vim.lsp.buf.references(nil, { on_list = on_list })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
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
