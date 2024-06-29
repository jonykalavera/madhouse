return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	config = function()
		require("neo-tree").setup({ close_if_last_window = true })
		-- neo-tree
		vim.keymap.set("n", "tt", ":Neotree filesystem toggle left<CR>")
	end,
}
