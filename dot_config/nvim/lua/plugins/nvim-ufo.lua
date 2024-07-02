return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.opt.foldcolumn = "1"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldenable = true

		require("ufo").setup({
			---@diagnostic disable-next-line: unused-local
			provider_selector = function(bufnr, fyletype, buftype)
				return { "lsp", "indent" }
			end,
		})
	end,
}
