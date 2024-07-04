return {
	"tanvirtin/vgit.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		require("vgit").setup({
			keymaps = {
				["n <M-k>"] = "hunk_up",
				["n <M-j>"] = "hunk_down",
				-- ["n <leader>g"] = "actions",
				["n <leader>gs"] = "buffer_hunk_stage",
				["n <leader>gr"] = "buffer_hunk_reset",
				["n <leader>gp"] = "buffer_hunk_preview",
				["n <leader>gb"] = "buffer_blame_preview",
				["n <leader>gf"] = "buffer_diff_preview",
				["n <leader>gH"] = "buffer_history_preview",
				["n <leader>gu"] = "buffer_reset",
				["n <leader>gg"] = "buffer_gutter_blame_preview",
				["n <leader>gd"] = "project_diff_preview",
				-- ["n <leader>gq"] = "project",
				["n <leader>gx"] = "toggle_diff_preference",
			},
		})
		local wk = require("which-key")

		wk.register({
			g = {
				name = "GIT", -- optional group name
				s = "Stage hunk in buffer",
				r = "Reset hunk in buffer",
				p = "Preview hunk in buffer",
				b = "Preview blame in buffer",
				f = "Buffer diff preview",
				H = "Buffer history preview",
				u = "Reset buffer",
				g = "Show blame gutter",
				d = "Project diff preview",
				x = "Toggle diff preference",
			},
		}, { prefix = "<leader>" })
	end,
}
