return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("spectre").setup({
			default = {
				replace = {
					cmd = "oxi",
				},
			},
			mapping = {
				["show_option_menu"] = {
					map = "<leader>so",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show options",
				},
			},
			find_engine = {
				-- rg is map with finder_cmd
				["rg"] = {
					cmd = "rg",
					-- default args
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--pcre2",
					},
					options = {
						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},
						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
						-- you can put any rg search option you want here it can toggle with
						-- show_option function
						["multiline"] = {
							value = "-U",
							desc = "multiline",
							icon = "[M]",
						},
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
			desc = "Toggle Spectre",
		})
		vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
			desc = "Search current word",
		})
		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
			desc = "Search on current file",
		})
	end,
}
