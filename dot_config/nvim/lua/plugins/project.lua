return {
	"ahmedkhalf/project.nvim",
	config = function()
		require("project_nvim").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			patterns = {
				".git",
				"_darcs",
				".hg",
				".bzr",
				".svn",
				"Makefile",
				"package.json",
				"lazy-lock.json",
				"*.csproj",
			},
		})
		require("telescope").load_extension("projects")
		vim.keymap.set("n", "<leader>pp", function()
			require("telescope").extensions.projects.projects({})
		end, { desc = "Select project" })
	end,
}
