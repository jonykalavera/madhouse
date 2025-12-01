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
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.auto_reload`.
			vim.o.autoread = true

			local opts = function(desc)
				return { desc = desc, silent = true, noremap = true }
			end

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<leader>oc", function()
				require("opencode").toggle()
			end, opts("Ask opencode"))
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
			-- -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			-- vim.keymap.set("n", "+", "<C-r>", opts("Increment"))
			-- vim.keymap.set("n", "-", "<C-x>", opts("Decrement"))
		end,
	},
}
