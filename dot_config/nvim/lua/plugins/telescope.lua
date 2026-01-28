return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>fa", function()
				builtin.find_files({ hidden = true })
			end, { desc = "Lists ALL files in your current working directory" })
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Lists files in your current working directory" })
			vim.keymap.set("n", "<Leader>fs", builtin.lsp_document_symbols, { desc = "Find syntax symbols in buffer." })
			vim.keymap.set(
				"n",
				"<Leader>fS",
				builtin.lsp_dynamic_workspace_symbols,
				{ desc = "Find syntax symbols in workspace" }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				builtin.treesitter,
				{ desc = "Lists Function names, variables, from Treesitter!" }
			)
			vim.keymap.set(
				"n",
				"<leader>fr",
				builtin.lsp_references,
				{ desc = "Lists LSP references for word under the cursor." }
			)
			vim.keymap.set("n", "<leader>fx", builtin.diagnostics, { desc = "Lists Diagnostics for all open buffers." })
			vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Lists available plugin/user commands." })
			vim.keymap.set(
				"n",
				"<C-S-p",
				builtin.command_history,
				{ desc = "Lists commands that were executed recently." }
			)
			vim.keymap.set("n", "<C-f><C-f>", function()
				require("telescope").extensions.live_grep_args.live_grep_args()
			end, { desc = "Search for a string in your current working directory" })
			vim.keymap.set("n", "<leader>fb", function()
				builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
			end, { desc = "Lists open buffers." })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Lists available help tags." })
			vim.keymap.set(
				"n",
				"<leader>fq",
				builtin.quickfix,
				{ desc = "Lists items in the quickfix list.", noremap = true }
			)
			vim.keymap.set(
				"n",
				"<leader>fp",
				builtin.builtin,
				{ desc = "Lists Built-in pickers and run them.", noremap = true }
			)
			vim.keymap.set("n", "<leader>fl", builtin.resume, { desc = "Resume the last picker.", noremap = true })
			-- GIT pickers
			vim.keymap.set(
				"n",
				"<Leader>Gb",
				builtin.git_branches,
				{ desc = "List git branches for current directory" }
			)
			vim.keymap.set("n", "<Leader>Gc", builtin.git_commits, { desc = "List git commits for current directory." })
			vim.keymap.set("n", "<Leader>GC", builtin.git_bcommits, { desc = "List git commits for current buffer." })
			vim.keymap.set("n", "<Leader>Gs", builtin.git_status, { desc = "Lists git status for current directory." })
			vim.keymap.set("n", "<Leader>GS", builtin.git_stash, { desc = "Lists git stash for current directory." })
			vim.keymap.set(
				"n",
				"<leader>fQ",
				builtin.quickfixhistory,
				{ desc = "Lists all quickfix lists in your history.", noremap = true }
			)
			-- local actions = require("telescope.actions")
			local open_with_trouble = require("trouble.sources.telescope").open

			-- Use this to add more results without clearing the trouble list
			local add_to_trouble = require("trouble.sources.telescope").add

			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<C-t>"] = open_with_trouble, ["<C-S-T>"] = add_to_trouble },
						n = { ["<C-t>"] = open_with_trouble, ["<C-S-T>"] = add_to_trouble },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					["live_grep_args"] = {
						additional_args = { "--hidden" },
					},
				},
			})
			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
			local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
			vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)
		end,
	},
}
