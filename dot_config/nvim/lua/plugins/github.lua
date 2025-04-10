return {
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup({
				suppress_missing_scope = {
					projects_v2 = true,
				},
			})
		end,
	},
	{
		"topaxi/pipeline.nvim",
		keys = {
			{ "<leader>ci", "<cmd>Pipeline<cr>", desc = "Open pipeline.nvim" },
		},
		-- optional, you can also install and use `yq` instead.
		build = "make",
		---@type pipeline.Config
		opts = {},
	},
}
