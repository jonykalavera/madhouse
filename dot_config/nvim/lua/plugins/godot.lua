return {
	-- {
	-- 	"habamax/vim-godot",
	-- 	event = "VimEnter",
	-- 	config = function()

	-- 	end,
	-- },
	{
		"Mathijs-Bakker/godotdev.nvim",
		dependencies = { "nvim-lspconfig", "nvim-dap", "nvim-dap-ui", "nvim-treesitter" },
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
				vim.fn.serverstart(vim.fn.getcwd() .. "/.godothost")
			end
		end,
	},
}
