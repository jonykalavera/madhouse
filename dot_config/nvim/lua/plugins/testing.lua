return {
	{
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
			"nsidorenco/neotest-vstest",
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
					require("neotest-vstest"),
					--   -- Path to dotnet sdk path.
					--   -- Used in cases where the sdk path cannot be auto discovered.
					--   sdk_path = "/usr/local/dotnet/sdk/9.0.101/",
					--   -- table is passed directly to DAP when debugging tests.
					--   dap_settings = {
					--     type = "netcoredbg",
					--   }
					--   -- If multiple solutions exists the adapter will ask you to choose one.
					--   -- If you have a different heuristic for choosing a solution you can provide a function here.
					--   solution_selector = function(solutions)
					--     return nil -- return the solution you want to use or nil to let the adapter choose.
					--   end
					--   build_opts = {
					--       -- Arguments that will be added to all `dotnet build` and `dotnet msbuild` commands
					--       additional_args = {}
					--   }
					-- })
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
	},
	{
		"andythigpen/nvim-coverage",
		version = "*",
		config = function()
			require("coverage").setup({
				auto_reload = true,
				-- lang = {
				-- 	cs = {
				-- 		-- Use Cobertura for .NET
				-- 		coverage_file = function()
				-- 			local patterns = {
				-- 				"TestResults/*/coverage.cobertura.xml",
				-- 				"*/TestResults/*/coverage.cobertura.xml",
				-- 				"coverage.cobertura.xml",
				-- 				".coverage/Cobertura.xml",
				-- 			}
				-- 			for _, pat in ipairs(patterns) do
				-- 				local m = vim.fn.glob(pat, false, true)
				-- 				if type(m) == "table" and #m > 0 then
				-- 					return m[1]
				-- 				elseif type(m) == "string" and m ~= "" then
				-- 					return m
				-- 				end
				-- 			end
				-- 			return nil
				-- 		end,
				-- 		-- Optional: map paths if report is from container/build server
				-- 		-- path_mappings = { ["/src"] = "" },
				-- 	},
				-- },
			})
		end,
	},
}
