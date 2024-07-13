return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local noice = require("noice")
			noice.setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
			require("telescope").load_extension("noice")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "molokai",
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.opt.foldcolumn = "1"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true

			---@diagnostic disable-next-line: missing-fields
			require("ufo").setup({
				---@diagnostic disable-next-line: unused-local
				provider_selector = function(bufnr, fyletype, buftype)
					return { "lsp", "indent" }
				end,
			})
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		-- dependencies = { "lewis6991/gitsigns.nvim" },
		config = function()
			local map = require("mini.map")
			local encode = map.gen_encode_symbols.dot("3x2")
			local search_integration = map.gen_integration.builtin_search()
			local diagnostic_integration = map.gen_integration.diagnostic({
				error = "DiagnosticFloatingError",
				warn = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			})
			local diff_integration = map.gen_integration.diff()
			map.setup({
				-- Highlight integrations (none by default)
				integrations = { diagnostic_integration, search_integration, diff_integration },

				-- Symbols used to display data
				symbols = {
					-- Encode symbols. See `:h MiniMap.config` for specification and
					-- `:h MiniMap.gen_encode_symbols` for pre-built ones.
					-- Default: solid blocks with 3x2 resolution.
					encode = encode,

					-- Scrollbar parts for view and line. Use empty string to disable any.
					scroll_line = "█",
					scroll_view = "┃",
				},

				-- Window options
				window = {
					-- Whether window is focusable in normal way (with `wincmd` or mouse)
					focusable = true,

					-- Side to stick ('left' or 'right')
					side = "right",

					-- Whether to show count of multiple integration highlights
					show_integration_count = true,

					-- Total width
					width = 10,

					-- Value of 'winblend' option
					winblend = 25,

					-- Z-index
					zindex = 10,
				},
			})
			vim.keymap.set("n", "<Leader>mx", MiniMap.close, { desc = "Close MiniMap" })
			vim.keymap.set("n", "<Leader>mf", MiniMap.toggle_focus, { desc = "Toggle focus on MiniMap" })
			vim.keymap.set("n", "<Leader>mo", MiniMap.open, { desc = "Open MiniMap" })
			vim.keymap.set("n", "<Leader>mr", MiniMap.refresh, { desc = "Refresh MiniMap" })
			vim.keymap.set("n", "<Leader>ms", MiniMap.toggle_side, { desc = "Toggle side MiniMap" })
			vim.keymap.set("n", "<Leader>mt", MiniMap.toggle, { desc = "Toggle MiniMap" })
			MiniMap.open()
			require("mini.diff").setup()
			require("mini.surround").setup({
				mappings = {
					add = "<Leader>sa", -- Add surrounding in Normal and Visual modes
					delete = "<Leader>sd", -- "Delete surrounding"
					find = "<Leader>sf", -- Find surrounding (to the right)
					find_left = "<Leader>sF", -- Find surrounding (to the left)
					highlight = "<Leader>sh", -- Highlight surrounding
					replace = "<Leader>sr", -- Replace surrounding
					update_n_lines = "<Leader>sn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
			})
			require("mini.pairs").setup()
			require("mini.operators").setup()
			-- require("mini.animate").setup()
		end,
	},
}
