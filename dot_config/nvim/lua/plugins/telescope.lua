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
			vim.keymap.set("n", "<C-p>", function(opts)
				builtin.find_files(opts, { sorter = require("mini.visits").gen_sort.default() })
			end, { desc = "Lists files in your current working directory" })
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
				"<leader>fC",
				builtin.command_history,
				{ desc = "Lists commands that were executed recently." }
			)
			vim.keymap.set(
				"n",
				"<leader>fg",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				{ desc = "Search for a string in your current working directory" }
			)
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Lists open buffers." })
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
			-- GIT pickers
			vim.keymap.set(
				"n",
				"<Leader>gb",
				builtin.git_branches,
				{ desc = "List git branches for current directory" }
			)
			vim.keymap.set("n", "<Leader>gc", builtin.git_commits, { desc = "List git commits for current directory." })
			vim.keymap.set("n", "<Leader>gC", builtin.git_bcommits, { desc = "List git commits for current buffer." })
			vim.keymap.set("n", "<Leader>gs", builtin.git_status, { desc = "Lists git status for current directory." })
			vim.keymap.set("n", "<Leader>gS", builtin.git_stash, { desc = "Lists git stash for current directory." })
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
				},
			})
			telescope.load_extension("live_grep_args")
			telescope.load_extension("ui-select")
		end,
	},
}
