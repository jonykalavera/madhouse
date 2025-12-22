return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"folke/which-key.nvim",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()` and `select()`.
			-- Required for default `toggle()` implementation.
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				provider = {
					enabled = "snacks",
				},
			}

			-- Required for `opts.auto_reload`.
			vim.o.autoread = true

			local opts = function(desc)
				return { desc = desc, silent = true, noremap = true }
			end

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-S-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<leader>oc", function()
				require("opencode").toggle()
			end, opts("Toggle opencode"))
			vim.keymap.set({ "n", "x" }, "<leader>ox", function()
				require("opencode").select()
			end, opts("Execute opencode action…"))
			vim.keymap.set({ "n", "x" }, "ga", function()
				require("opencode").prompt("@this")
			end, opts("Add to opencode"))
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("messages_half_page_up")
			end, opts("opencode half page up"))
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("messages_half_page_down")
			end, opts("opencode half page down"))

			--- Check if a file or directory exists in this path
			local directory_exists = function(file)
				local ok, err, code = os.rename(file, file)
				if not ok then
					if code == 13 then
						-- Permission denied, but it exists
						return true
					end
				end
				return ok, err
			end
			local ocproject = directory_exists(vim.fn.getcwd() .. "/.opencode")
			if ocproject then
				local ok, err = pcall(vim.fn.serverstart, vim.fn.getcwd() .. "/.godothost")
				if ok then
					vim.notify("Opencode project found, starting server", vim.log.levels.INFO)
				else
					vim.notify("Opencode: " .. err, vim.log.levels.WARN)
				end
			end
		end,
	},
}
