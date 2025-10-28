-- return {
-- 	"tpope/vim-dadbod",
-- 	"kristijanhusak/vim-dadbod-completion",
-- 	{
-- 		"kristijanhusak/vim-dadbod-ui",
-- 		config = function()
-- 			vim.keymap.set("n", "<Leader>da", ":DBUIToggle<CR>", { desc = "DadBod UI" })
-- 		end,
-- 	},
-- }
return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1

		vim.keymap.set("n", "<Leader>da", ":DBUIToggle<CR>", { desc = "DadBod UI" })
	end,
}
