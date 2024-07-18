return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				python = { "ruff", "mypy" },
				markdown = { "markdownlint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
	{
		"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
		config = function()
			require("toggle_lsp_diagnostics").init({ underline = true })
			vim.keymap.set(
				"n",
				"<leader>tlu",
				"<Plug>(toggle-lsp-diag-underline)",
				{ desc = "Toggle diagnostics underline" }
			)
			vim.keymap.set("n", "<leader>tls", "<Plug>(toggle-lsp-diag-signs)", { desc = "Toggle diagnostics signs" })
			vim.keymap.set(
				"n",
				"<leader>tlv",
				"<Plug>(toggle-lsp-diag-vtext)",
				{ desc = "Toggle diagnostics virtual text" }
			)
			vim.keymap.set(
				"n",
				"<leader>tlp",
				"<Plug>(toggle-lsp-diag-update_in_insert)",
				{ desc = "Toggle diagnostics update-in-insert" }
			)

			vim.keymap.set("n", "<leader>tld", "<Plug>(toggle-lsp-diag)", { desc = "Toggle diagnostics" })
			vim.keymap.set(
				"n",
				"<leader>tldd",
				"<Plug>(toggle-lsp-diag-default)",
				{ desc = "Toggle diagnostics default" }
			)
			vim.keymap.set("n", "<leader>tldo", "<Plug>(toggle-lsp-diag-off)", { desc = "Toggle diagnostics OFF" })
			vim.keymap.set("n", "<leader>tldf", "<Plug>(toggle-lsp-diag-on)", { desc = "Toggle diagnostics ON" })
		end,
	},
}
