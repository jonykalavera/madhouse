return {
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				-- Make sure you have this in your options:
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name, _)
						local hidden_patterns = {
							"^%.",
							"%.uid[/]?$", -- .uid files
							"%.import[/]?$", -- .import files
							"^%.godot[/]?$", -- .godot directory
							"^%.mono[/]?$", -- .mono directory
							"godot.*%.tmp$", -- godot temp files
						}
						for _, pat in ipairs(hidden_patterns) do
							if name:match(pat) then
								return true
							end
						end
						return false
					end,
				},
			})
			vim.keymap.set("n", "<Leader>oo", "<CMD>:Oil --float<CR>", { desc = "Toggle Oil" })
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
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-neotest/neotest" },
		config = function()
			local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }
			local neotest_component = function()
				local ok, neotest = pcall(require, "neotest")
				if not ok or not neotest.state then
					return "neotest not loaded"
				end

				local adapters = neotest.state.adapter_ids()
				if not adapters or vim.tbl_isempty(adapters) then
					return ""
				end
				local stats = {}
				local counterIcons = {
					total = "",
					passed = "✔",
					failed = "✖",
					skipped = "↷",
					running = "●",
				}
				local counters = {}
				for _, adapter in ipairs(adapters) do
					local status_counts = neotest.state.status_counts(adapter)
					if status_counts then
						for counter, value in pairs(status_counts) do
							counters[counter] = (counters[counter] or 0) + value
						end
					end
				end
				for counter, icon in pairs(counterIcons) do
					local value = counters[counter]
					if icon and value and value > 0 then
						table.insert(stats, icon .. " " .. value)
					end
				end

				-- Rebuild output preserving order; show icons only if count > 0 (total always)
				stats = {}
				local order = { "total", "passed", "failed", "skipped", "running" }
				for _, key in ipairs(order) do
					local value = counters[key] or 0
					if value > 0 or key == "total" then
						table.insert(stats, string.format("%s %d", counterIcons[key], value))
					end
				end
				return table.concat(stats, "  ")
			end

			require("lualine").setup({
				options = {
					theme = "molokai",
				},
				sections = {
					lualine_a = { "mode", job_indicator },
					lualine_c = { "filename", neotest_component },
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			vim.notify.setup({
				render = "compact",
				timeout = 3000,
				top_down = false,
				merge_duplicates = true,
			})
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
			-- *************************************************************************
			-- MiniMap
			-- *************************************************************************
			local minmap = require("mini.map")
			local encode = minmap.gen_encode_symbols.dot("3x2")
			local search_integration = minmap.gen_integration.builtin_search()
			local diagnostic_integration = minmap.gen_integration.diagnostic({
				error = "DiagnosticFloatingError",
				warn = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			})
			local gitsigns_integration = minmap.gen_integration.gitsigns()
			minmap.setup({
				-- Highlight integrations (none by default)
				integrations = { diagnostic_integration, search_integration, gitsigns_integration },

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
			-- *************************************************************************
			-- MiniSurround
			-- *************************************************************************
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
			vim.keymap.set("x", '"', [[:<C-u>lua MiniSurround.add('visual')<CR>"]], { silent = true })
			vim.keymap.set("x", "'", [[:<C-u>lua MiniSurround.add('visual')<CR>']], { silent = true })
			vim.keymap.set("x", "`", [[:<C-u>lua MiniSurround.add('visual')<CR>`]], { silent = true })
			vim.keymap.set("x", "[", [[:<C-u>lua MiniSurround.add('visual')<CR>[]], { silent = true })
			vim.keymap.set("x", "{", [[:<C-u>lua MiniSurround.add('visual')<CR>{]], { silent = true })
			vim.keymap.set("x", "(", [[:<C-u>lua MiniSurround.add('visual')<CR>(]], { silent = true })

			-- *************************************************************************
			-- MiniPairs
			-- *************************************************************************
			require("mini.pairs").setup({})

			-- *************************************************************************
			-- MiniVisits
			-- *************************************************************************
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

			-- *************************************************************************
			-- MiniHipatterns
			-- *************************************************************************
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

					-- 'Highlight' hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons", "echasnovski/mini.bufremove" },
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
					{
						filetype = "opencode",
					},
					{
						filetype = "qf",
					},
				},
				filter = function(buf)
					return vim.bo[buf].buftype ~= "terminal"
				end,
				close_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
				right_mouse_command = function(n)
					require("mini.bufremove").delete(n, false)
				end,
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")

			local Terminal = require("toggleterm.terminal").Terminal
			-- function to run on opening the terminal
			local on_open = function()
				vim.cmd("startinsert!")
			end
			-- function to run on closing the terminal
			---@diagnostic disable-next-line: unused-local
			local on_close = function(term)
				vim.cmd("startinsert!")
			end
			-- ToggleTerm setup
			toggleterm.setup({
				open_mapping = { [[<c-\>]], [[<C-º>]] },
				on_close = on_close,
				on_open = on_open,
				shade_terminals = false,
			})

			-- Custom terminal
			local lazygit = Terminal:new({
				cmd = "lazygit",
				hidden = false,
				direction = "float",
				display_name = "LazyGit",
			})
			local lazydocker = Terminal:new({
				cmd = "lazydocker",
				hidden = true,
				direction = "float",
				display_name = "LazyDocker",
			})
			local k9s = Terminal:new({
				cmd = "k9s",
				hidden = true,
				direction = "float",
				display_name = "K9s",
			})

			local harlequin = Terminal:new({
				cmd = "harlequin",
				hidden = false,
				direction = "float",
				display_name = "Harlequin",
			})
			local lazyredis = Terminal:new({
				cmd = "lazyredis",
				hidden = false,
				direction = "float",
				display_name = "LazyRedis",
			})
			local slumber = Terminal:new({
				cmd = "slumber",
				hidden = true,
				direction = "float",
				display_name = "Slumber",
			})

			vim.keymap.set("n", "<leader>lg", function()
				lazygit:toggle()
			end, { noremap = true, silent = true, desc = "LazyGit" })
			vim.keymap.set("n", "<leader>ld", function()
				lazydocker:toggle()
			end, { noremap = true, silent = true, desc = "LazyDocker" })
			vim.keymap.set("n", "<leader>k9", function()
				k9s:toggle()
			end, { noremap = true, silent = true, desc = "K9s" })
			vim.keymap.set("n", "<leader>hq", function()
				harlequin:toggle()
			end, { noremap = true, silent = true, desc = "LazySQL" })
			vim.keymap.set("n", "<leader>lr", function()
				lazyredis:toggle()
			end, { noremap = true, silent = true, desc = "LazyRedis" })
			vim.keymap.set("n", "<leader>sl", function()
				slumber:toggle()
			end, { noremap = true, silent = true, desc = "Slumber" })
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
	{
		"https://git.sr.ht/~havi/telescope-toggleterm.nvim",
		event = "TermOpen",
		requires = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("toggleterm")
			require("telescope-toggleterm").setup({
				telescope_mappings = {
					-- <ctrl-c> : kill the terminal buffer (default) .
					["<C-c>"] = require("telescope-toggleterm").actions.exit_terminal,
				},
			})
			vim.keymap.set(
				"n",
				"<leader>T",
				"<cmd>Telescope toggleterm<cr>",
				{ noremap = true, desc = "Telescope toggleterm" }
			)
		end,
	},
}
