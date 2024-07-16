return {
	"tanvirtin/vgit.nvim",
	requires = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("vgit").setup({
			keymaps = {
				["n <C-M-k>"] = function()
					require("vgit").hunk_up()
				end,
				["n <C-M-j>"] = function()
					require("vgit").hunk_down()
				end,
				["n <leader>gs"] = function()
					require("vgit").buffer_hunk_stage()
				end,
				["n <leader>gr"] = function()
					require("vgit").buffer_hunk_reset()
				end,
				["n <leader>gp"] = function()
					require("vgit").buffer_hunk_preview()
				end,
				["n <leader>gb"] = function()
					require("vgit").buffer_blame_preview()
				end,
				["n <leader>gf"] = function()
					require("vgit").buffer_diff_preview()
				end,
				["n <leader>gH"] = function()
					require("vgit").buffer_history_preview()
				end,
				["n <leader>gu"] = function()
					require("vgit").buffer_reset()
				end,
				["n <leader>gg"] = function()
					require("vgit").buffer_gutter_blame_preview()
				end,
				["n <leader>glu"] = function()
					require("vgit").buffer_hunks_preview()
				end,
				["n <leader>gls"] = function()
					require("vgit").project_hunks_staged_preview()
				end,
				["n <leader>gd"] = function()
					require("vgit").project_diff_preview()
				end,
				["n <leader>gq"] = function()
					require("vgit").project_hunks_qf()
				end,
				["n <leader>gx"] = function()
					require("vgit").toggle_diff_preference()
				end,
			},
		})
		require("which-key").add({
			{ "<Leader>g", group = "GIT" },
			{ "<Leader>gs", desc = "Stage current hunk" },
			{ "<Leader>gr", desc = "Reset current hunk" },
			{
				"<Leader>gp",
				desc = "Preview current hunk",
			},
			{
				"<Leader>gb",
				desc = "Preview blame in buffer",
			},
			{ "<Leader>gf", desc = "Buffer Diff preview" },
			{ "<Leader>gH", desc = "Buffer history preview" },
			{ "<Leader>gu", desc = "Reset buffer" },
			{ "<Leader>gg", desc = "Gutter Blame preview" },
			{ "<Leader>glu", desc = "Preview Buffer hunks" },
			{ "<Leader>gls", desc = "Preview staged Project Hunks" },
			{ "<Leader>gd", desc = "Project Diff preview" },
			{ "<Leader>gq", desc = "Create QFL of project hunks" },
			{ "<Leader>gx", desc = "Roxygen Edit" },
		})
	end,
}
