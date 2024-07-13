return {
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
	{
		"kristijanhusak/vim-dadbod-ui",
		config = function()
			vim.keymap.set("n", "<Leader>da", ":DBUI<CR>", { desc = "DadBod UI" })
		end,
	},
}
