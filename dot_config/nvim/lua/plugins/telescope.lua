return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			-- vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			-- vim.keymap.set("n", "<leader>ff", builtin.live_grep, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"FeiyouG/commander.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>f", "<CMD>Telescope commander<CR>", mode = "n" },
			{ "<leader>fc", "<CMD>Telescope commander<CR>", mode = "n" },
			{ "<leader>ff", "<CMD>Telescope live_grep<CR>", mode = "n" },
			{ "<C-p>", "<CMD>Telescope find_files<CR>", mode = "n" },
		},
		config = function()
			require("commander").setup({
				components = {
					"DESC",
					"KEYS",
					"CAT",
				},
				sort_by = {
					"DESC",
					"KEYS",
					"CAT",
					"CMD",
				},
				integration = {
					telescope = {
						enabled = true,
					},
					lazy = {
						enable = true,
						-- Set to true to use plugin name as category for each keybinding added from lazy.nvim
						set_plugin_name_as_cat = true,
					},
				},
			})
			-- Add a new command
			require("commander").add({
				{
					desc = "Format buffer",
					cmd = vim.lsp.buf.format,
					keys = { "n", "<Leader>gf" },
				},
			})
		end,
	},
}
