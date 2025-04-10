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
				vim.cmd(":Neotree close<CR>")
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
			local opts = function(desc)
				return { noremap = true, silent = true, desc = desc }
			end
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, opts("Toggle breakpoint"))
			vim.keymap.set("n", "<F5>", dap.continue, opts("Debug / continue"))

			-- python
			local dap_python = require("dap-python")
			dap_python.setup("~/.config/nvim/venv/bin/python")
			dap_python.test_runner = "pytest"
			-- nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
			vim.keymap.set("n", "<leader>dn", dap_python.test_method, opts("Test current method"))
			-- nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
			vim.keymap.set("n", "<leader>df", dap_python.test_class, opts("Test current class"))
			-- vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
			vim.keymap.set("v", "<leader>ds", dap_python.test_class, opts("Test current class"))

			dapui.setup()
		end,
	},
}
