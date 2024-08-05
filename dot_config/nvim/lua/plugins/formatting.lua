return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					charp = { "csharpier" },
					python = function(bufnr)
						if conform.get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
						else
							return { "isort", "black" }
						end
					end,
					gdscript = { "gdtoolkit" },
				},
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return {
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					}
				end,
			})

			vim.keymap.set({ "n", "v" }, "<leader>ff", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })

			vim.keymap.set({ "n" }, "<leader>ftb", function()
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				vim.notify("Buffer auto-format on-save: " .. (vim.b.disable_autoformat and "OFF" or "ON"), vim.log.levels.INFO)
			end, { desc = "Toggle auto-format on-save for buffer." })
			vim.keymap.set({ "n" }, "<leader>ftg", function()
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				vim.notify("Global auto-format on-save: " .. (vim.g.disable_autoformat and "OFF" or "ON"), vim.log.levels.INFO)
			end, { desc = "Toggle auto-format on-save globally." })
		end,
	},
}
