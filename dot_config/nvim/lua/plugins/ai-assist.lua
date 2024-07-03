return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- Optional
		{
			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
			opts = {},
		},
	},
	config = function()
		local codecompanion = require("codecompanion")
		codecompanion.setup({
			strategies = {
				chat = "ollama",
				inline = "ollama",
				agent = "ollama",
			},
			adapters = {
				ollama = require("codecompanion.adapters").use("ollama", {
					schema = {
						model = {
							default = "llama3:latest",
						},
					},
				}),
			},
		})
		local opts = function(desc)
			return { noremap = true, silent = true, desc = desc }
		end
		vim.keymap.set("n", "<Leader>cca", "<cmd>CodeCompanionActions<cr>", opts("Code Companion Actions"))
		vim.keymap.set("v", "<Leader>cca", "<cmd>CodeCompanionActions<cr>", opts("Code Companion Actions"))
		vim.keymap.set("n", "<Leader>ca", "<cmd>CodeCompanionToggle<cr>", opts("Toggle Code Companion"))
		vim.keymap.set("v", "<Leader>ca", "<cmd>CodeCompanionToggle<cr>", opts("Toggle Code Companion"))
		vim.keymap.set("v", "<Leader>ga", "<cmd>CodeCompanionAdd<cr>", opts("Add to Code Companion"))

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
