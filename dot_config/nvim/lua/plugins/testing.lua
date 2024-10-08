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
		"nvim-neotest/neotest-jest",
	},
	config = function()
		local neotest = require("neotest")
		---@diagnostic disable-next-line: missing-fields
		neotest.setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					pytest_discover_instances = true,
				}),
				require("neotest-plenary"),
				require("neotest-vim-test")({
					ignore_file_types = { "python", "vim", "lua" },
				}),
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					---@diagnostic disable-next-line: unused-local
					cwd = function(path)
						return vim.g.jest_tests_path or vim.fn.getcwd()
					end,
				}),
			},
		})

		-- keymaps
		vim.keymap.set("n", "<leader>tt", function()
			neotest.run.run()
		end, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>td", function()
			---@diagnostic disable-next-line: missing-fields
			neotest.run.run({ strategy = "dap" })
		end, { desc = "Debug nearest test" })
		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run tests in file" })
		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.stop()
		end, { desc = "Stop nearest test" })
		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.attach()
		end, { desc = "Attach to nearest test" })
		vim.keymap.set("n", "<leader>tT", function()
			neotest.summary.toggle()
		end, { desc = "Toggle summary" })
		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open({ enter = true })
		end, { desc = "Open output window" })
		vim.keymap.set("n", "<leader>tO", function()
			neotest.output_panel.toggle()
		end, { desc = "Toggle output panel" })
	end,
}
