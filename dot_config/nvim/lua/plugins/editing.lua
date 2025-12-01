return {
	{
		"mireq/large_file",
		config = function()
			require("large_file").setup()
		end,
	},
	{
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	{ "tpope/vim-abolish" },
}
