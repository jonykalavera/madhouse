return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "neovim/nvim-lspconfig" },
		config = function()
			local handlers = require("common.handlers")
			local dotnet = require("easy-dotnet")
			dotnet.setup({
				debugger = {
					--name if netcoredbg is in PATH or full path like 'C:\Users\gusta\AppData\Local\nvim-data\mason\bin\netcoredbg.cmd'
					bin_path = "netcoredbg",
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
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("easy_dotnet", {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					handlers.on_attach(client, args.buf)
				end,
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.cs,*.csproj,*.sln,*.slnx,*.props,*.targets" },
				--command = solution.LoadSolution,
				callback = function(evt)
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
