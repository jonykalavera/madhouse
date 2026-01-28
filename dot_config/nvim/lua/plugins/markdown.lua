return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function() vim.fn["mkdp#util#install"]() end,
	config = function()
		vim.g.mkdp_port = "8081"
		vim.g.mkdp_echo_preview_url = 1
	end,
}
