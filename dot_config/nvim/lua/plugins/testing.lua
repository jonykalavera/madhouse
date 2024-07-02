return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-plenary",
		"nvim-neotest/neotest-vim-test",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua" },
				}),
			},
		})

		-- keymaps
		vim.keymap.set("n", "<leader>tt", function() neotest.run.run(); end, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }); end, { desc = "Debug nearest test" })
		vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")); end, { desc = "Run tests in file" })
		vim.keymap.set("n", "<leader>ts", function() neotest.run.stop(); end, { desc = "Stop nearest test" })
		vim.keymap.set("n", "<leader>ts", function() neotest.run.attach(); end, { desc = "Attach to nearest test" })
	end,
}
