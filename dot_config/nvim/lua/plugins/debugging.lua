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
			dap.listeners.before.attach.dapui_config = function()
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
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<F5>", dap.continue)

            -- python
            local dap_python = require("dap-python")
            dap_python.setup("~/.config/nvim/venv/bin/python")
            dap_python.test_runner = 'pytest'

            dapui.setup({})
        end
    }
}
