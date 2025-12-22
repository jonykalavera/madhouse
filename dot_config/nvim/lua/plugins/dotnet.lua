return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				-- lsp = {
				-- 	enabled = false,
				-- },
				debugger = {
					bin_path = "netcoredbg",
				},
				notifications = {
					--Set this to false if you have configured lualine to avoid double logging
					handler = false,
				},
			})

			local opts = function(desc)
				return { silent = true, noremap = true, desc = desc, buffer = true }
			end

			local FixProjectSlashes = function()
				for _, f in ipairs(vim.fn.glob("**/*.{csproj,props,targets,slnx}", true, true)) do
					vim.cmd("edit " .. vim.fn.fnameescape(f))
					vim.cmd([[%s/\\/\//ge]])
					vim.cmd("update")
				end
			end

			-- CS Projects
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.cs,*.csproj,*.sln,*.slnx,*.props,*.targets" },
				--command = solution.LoadSolution,
				callback = function(_)
					vim.api.nvim_create_user_command("FixProjectSlashes", FixProjectSlashes, {})
					vim.keymap.set("n", "<leader>ps", ":FixProjectSlashes<CR>", opts("Fix project slashes"))

					vim.keymap.set("n", "<leader>pv", function()
						dotnet.project_view()
					end, opts("Project view"))
				end,
			})
		end,
	},
}
