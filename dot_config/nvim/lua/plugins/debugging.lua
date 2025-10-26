return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dap.set_exception_breakpoints({ "raised", "uncaught" })

			vim.cmd("hi DapBreakpointColor guifg=#fa4848")
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "⭕", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "🛑", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "🪧", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "My custom launch configuration",
					justMyCode = false,
					program = "${file}",
				},
			}
			dap.adapters.godot = {
				type = "server",
				host = "127.0.0.1",
				port = 6006,
			}
			dap.configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
					launch_scene = true,
				},
			}
			dap.listeners.before.attach.dapui_config = function()
				vim.cmd(":Pipeline close<CR>")
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			-- dap.listeners.after.event_initialized["set_exception_breakpoints"] = function()
			-- 	dap.set_exception_breakpoints({"Error", "Exception"})
			-- end
			local opts = function(desc)
				return { noremap = true, silent = true, desc = desc }
			end
			-- nnoremap <silent> <Leader>db <Cmd>lua require'dap'.toggle_breakpoint()<CR>
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, opts("Toggle breakpoint"))
			-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
			vim.keymap.set("n", "<F5>", dap.continue, opts("Debug / continue"))
			-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
			vim.keymap.set("n", "<F10>", dap.step_over, opts("Step over"))
			-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
			vim.keymap.set("n", "<F11>", dap.step_over, opts("Step into"))
			-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
			vim.keymap.set("n", "<F12>", dap.step_over, opts("Step out"))
			-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
			-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
			-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
			-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

			-- python
			local dap_python = require("dap-python")
			dap_python.setup("uv")
			dap_python.test_runner = "pytest"
			vim.keymap.set("n", "<leader>dn", dap_python.test_method, opts("Test current method"))
			vim.keymap.set("n", "<leader>df", dap_python.test_class, opts("Test current class"))
			vim.keymap.set("v", "<leader>ds", dap_python.test_class, opts("Test current class"))
			require("easy-dotnet.netcoredbg").register_dap_variables_viewer()
			dapui.setup()
		end,
	},
	{
		"lucaSartore/nvim-dap-exception-breakpoints",
		dependencies = { "mfussenegger/nvim-dap" },

		config = function()
			local set_exception_breakpoints = require("nvim-dap-exception-breakpoints")

			vim.api.nvim_set_keymap(
				"n",
				"<leader>dc",
				"",
				{ desc = "[D]ebug [C]ondition breakpoints", callback = set_exception_breakpoints }
			)
		end,
	},
}
