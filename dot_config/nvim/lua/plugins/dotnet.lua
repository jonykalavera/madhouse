return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local handlers = require("common.handlers")
			-- Customize DAP config
			local dap = require("dap")

			-- Verifica si la configuración de C# existe y tiene al menos un perfil
			if dap.configurations.cs and dap.configurations.cs > 0 then
				-- Asumimos que el primer perfil de configuración es el que usa easy-dotnet.nvim
				local config = dap.configurations.cs[1]

				-- 1. Deshabilita 'Just My Code' para permitir el paso a código externo
				config.justMyCode = false

				-- 2. (Opcional pero recomendado) Asegura que el depurador busque símbolos
				-- en el servidor de símbolos de Microsoft para descargar el código fuente.
				if not config.symbolSearchPaths then
					config.symbolSearchPaths = {}
				end
				table.insert(config.symbolSearchPaths, "https://msdl.microsoft.com/download/symbols")

				-- Si easy-dotnet.nvim usa un nombre de perfil específico, puedes buscarlo por nombre
				-- en lugar de usar el índice [1].
				vim.notify("Custom DAP config applied.", vim.log.levels.INFO)
			end
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				lsp = {
					config = { on_attach = handlers.on_attach },
				},
				-- debugger = {
				-- 	--name if netcoredbg is in PATH or full path like 'C:\Users\gusta\AppData\Local\nvim-data\mason\bin\netcoredbg.cmd'
				-- 	bin_path = "netcoredbg",
				-- },
				-- mappings = {
				-- 	run_test_from_buffer = { lhs = "<leader>tf", desc = "run test from buffer" },
				-- 	peek_stack_trace_from_buffer = { lhs = "<leader>dp", desc = "peek stack trace from buffer" },
				-- 	-- filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
				-- 	-- debug_test = { lhs = "<leader>d", desc = "debug test" },
				-- 	-- go_to_file = { lhs = "g", desc = "go to file" },
				-- 	-- run_all = { lhs = "<leader>R", desc = "run all tests" },
				-- 	-- run = { lhs = "<leader>r", desc = "run test" },
				-- 	-- peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
				-- 	-- expand = { lhs = "o", desc = "expand" },
				-- 	-- expand_node = { lhs = "E", desc = "expand node" },
				-- 	-- expand_all = { lhs = "-", desc = "expand all" },
				-- 	-- collapse_all = { lhs = "W", desc = "collapse all" },
				-- 	-- close = { lhs = "q", desc = "close testrunner" },
				-- 	-- refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
				-- },
			})

			local opts = function(desc)
				return { silent = true, noremap = true, desc = desc, buffer = true }
			end

			local FixProjectSlashes = function()
				for _, f in ipairs(vim.fn.glob("**/*.{csproj,props,targets,slnx}", true, true)) do
					vim.cmd("edit " .. vim.fn.fnameescape(f))
					vim.cmd([[%s/\\/\//ge]])
					vim.cmd("update")
				end
			end

			-- CS Projects
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.cs,*.csproj,*.sln,*.slnx,*.props,*.targets" },
				--command = solution.LoadSolution,
				callback = function()
					vim.api.nvim_create_user_command("FixProjectSlashes", FixProjectSlashes, {})
					vim.keymap.set("n", "<leader>ps", ":FixProjectSlashes<CR>", opts("Fix project slashes"))

					vim.keymap.set("n", "<leader>pv", function()
						dotnet.project_view()
					end, opts("Project view"))
				end,
			})
		end,
	},
}
