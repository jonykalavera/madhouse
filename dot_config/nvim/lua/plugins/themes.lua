return {
	{
		"niyabits/calvera-dark.nvim",
		priority = 1000,
		config = function()
			-- Optional Example Configuration
			vim.g.calvera_italic_keywords = true
			vim.g.calvera_borders = true
			vim.g.calvera_contrast = true
			vim.g.calvera_hide_eob = true
			vim.g.calvera_custom_colors = { contrast = "#0f111a" }
		end,
	},
}
