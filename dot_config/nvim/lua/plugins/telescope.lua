return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<C-r>", builtin.treesitter, { desc = "Find syntax symbols" })
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Find references" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find in files / Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
			vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Find quickfix", noremap = true })
			vim.keymap.set(
				"n",
				"<leader>fQ",
				builtin.quickfixhistory,
				{ desc = "Find quickfix history", noremap = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fQ",
				builtin.quickfixhistory,
				{ desc = "Find quickfix history", noremap = true }
			)
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
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		-- This will not install any breaking changes.
		-- For major updates, this must be adjusted manually.
		version = "^1.0.0",
		config = function()
			local telescope = require("telescope")

			-- first setup telescope
			telescope.setup({
				-- your config
			})

			-- then load the extension
			telescope.load_extension("live_grep_args")
		end,
	},
}
