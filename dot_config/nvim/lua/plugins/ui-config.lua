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
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" },
		config = function()
			local trouble = require("trouble")
			local symbols = trouble.statusline({
				mode = "lsp_document_symbols",
				groups = {},
				title = false,
				filter = { range = true },
				format = "{kind_icon}{symbol.name:Normal}",
				-- The following line is needed to fix the background color
				-- Set it to the lualine section you want to use
				hl_group = "lualine_c_normal",
			})
			require("lualine").setup({
				options = {
					theme = "molokai",
					sections = {
						lualine_c = {
							symbols.get,
							cond = symbols.has,
						},
					},
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
		dependencies = { "lewis6991/gitsigns.nvim" },
		config = function()
			local minmap = require("mini.map")
			local encode = minmap.gen_encode_symbols.dot("3x2")
			local search_integration = minmap.gen_integration.builtin_search()
			local diagnostic_integration = minmap.gen_integration.diagnostic({
				error = "DiagnosticFloatingError",
				warn = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			})
			local diff_integration = minmap.gen_integration.diff()
			local gitsigns_integration = minmap.gen_integration.gitsigns()
			minmap.setup({
				-- Highlight integrations (none by default)
				integrations = { diagnostic_integration, search_integration, diff_integration, gitsigns_integration },

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
			require("mini.visits").setup()
			local make_select_path = function(select_global, recency_weight)
				local visits = require("mini.visits")
				local sort = visits.gen_sort.default({ recency_weight = recency_weight })
				local select_opts = { sort = sort }
				return function()
					local cwd = select_global and "" or vim.fn.getcwd()
					visits.select_path(cwd, select_opts)
				end
			end

			local map = function(lhs, desc, ...)
				vim.keymap.set("n", lhs, make_select_path(...), { desc = desc })
			end

			-- Adjust LHS and description to your liking
			map("<Leader>vr", "Select recent (all)", true, 1)
			map("<Leader>vR", "Select recent (cwd)", false, 1)
			map("<Leader>vy", "Select frecent (all)", true, 0.5)
			map("<Leader>vY", "Select frecent (cwd)", false, 0.5)
			map("<Leader>vf", "Select frequent (all)", true, 0)
			map("<Leader>vF", "Select frequent (cwd)", false, 0)
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
}
