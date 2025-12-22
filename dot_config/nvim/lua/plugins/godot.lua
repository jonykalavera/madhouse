return {
	-- {
	-- 	"habamax/vim-godot",
	-- 	event = "VimEnter",
	-- 	config = function()

	-- 	end,
	-- },
	{
		"Mathijs-Bakker/godotdev.nvim",
		dependencies = { "nvim-lspconfig", "nvim-dap", "nvim-dap-ui", "nvim-treesitter", "folke/noice.nvim" },
		config = function()
			require("godotdev").setup({
				editor_host = "127.0.0.1", -- Godot editor host
				editor_port = 6005, -- LSP port
				debug_port = 6006, -- DAP port
				csharp = false, -- enable C# support
			})
			local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
			if gdproject then
				io.close(gdproject)
				local ok, err = pcall(vim.fn.serverstart, vim.fn.getcwd() .. "/.godothost")
				if ok then
					vim.notify("Godot project found, starting server", vim.log.levels.INFO, { title = "Godot" })
				else
					vim.notify("Godot: " .. err, vim.log.levels.WARN, { title = "Godot" })
				end
			end

			local dap = require("dap")

			dap.configurations.cs = dap.configurations.cs or {}

			local function pick_godot_process()
				local cwd = vim.fn.getcwd()
				local utils = require("dap.utils")
				local cmd = ("ps -eo pid=,args= | grep -i godot | grep -F -- %q | grep -v grep"):format(cwd)
				local lines = vim.fn.systemlist(cmd)
				local pids = {}
				for _, l in ipairs(lines) do
					local pid = tonumber(l:match("^%s*(%d+)"))
					if pid then
						table.insert(pids, pid)
					end
				end
				if #pids == 1 then
					return pids[1]
				end
				return utils.pick_process({ filter = "godot" })
			end

			table.insert(dap.configurations.cs, {
				type = "netcoredbg",
				name = "Attach to Godot",
				request = "attach",
				processId = pick_godot_process,
				cwd = "${workspaceFolder}",
			})
		end,
	},
}
