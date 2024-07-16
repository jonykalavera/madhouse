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
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			local chatgpt = require("chatgpt")
			local wk = require("which-key")
			chatgpt.setup({
				api_key_cmd = vim.g.use_chatgpt and "op read op://Personal/ChatGPT/password --no-newline" or "echo ''",
				actions_paths = { "~/.config/nvim/chatgpt-actions.json" },
				openai_params = {
					-- NOTE: model can be a function returning the model name
					-- this is useful if you want to change the model on the fly
					-- using commands
					-- Example:
					-- model = function()
					--     if some_condition() then
					--         return "gpt-4-1106-preview"
					--     else
					--         return "gpt-3.5-turbo"
					--     end
					-- end,
					model = "gpt-4-1106-preview",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 4095,
					temperature = 0.2,
					top_p = 0.1,
					n = 1,
				},
			})
			wk.add({
				{ "<Leader>a", group = "ChatGPT" },
				{ "<Leader>ac", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
				{ "<Leader>ac", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
				{
					"<Leader>ae",
					"<cmd>ChatGPTEditWithInstruction<CR>",
					desc = "Edit with instruction",
					mode = { "n", "v" },
				},
				{
					"<Leader>ag",
					"<cmd>ChatGPTRun grammar_correction<CR>",
					desc = "Grammar Correction",
					mode = { "n", "v" },
				},
				{ "<Leader>at", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
				{ "<Leader>ak", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
				{ "<Leader>ad", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
				{ "<Leader>aa", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
				{ "<Leader>ao", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
				{ "<Leader>as", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
				{ "<Leader>af", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
				{ "<Leader>ax", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
				{ "<Leader>ar", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
				{
					"<Leader>al",
					"cmd>ChatGPTRun code_readability_analysis<CR>",
					desc = "Code Readability Analysis",
					mode = { "n", "v" },
				},
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-telescope/telescope.nvim", -- Optional
	-- 		{
	-- 			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
	-- 			opts = {},
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		local codecompanion = require("codecompanion")
	-- 		codecompanion.setup({
	-- 			strategies = {
	-- 				chat = "ollama",
	-- 				inline = "ollama",
	-- 				agent = "ollama",
	-- 			},
	-- 			adapters = {
	-- 				ollama = require("codecompanion.adapters").use("ollama", {
	-- 					schema = {
	-- 						model = {
	-- 							default = "llama3:latest",
	-- 						},
	-- 					},
	-- 				}),
	-- 			},
	-- 		})
	-- 		local opts = function(desc)
	-- 			return { noremap = true, silent = true, desc = desc }
	-- 		end
	-- 		vim.keymap.set("n", "<Leader>cca", "<cmd>CodeCompanionActions<cr>", opts("Code Companion Actions"))
	-- 		vim.keymap.set("v", "<Leader>cca", "<cmd>CodeCompanionActions<cr>", opts("Code Companion Actions"))
	-- 		vim.keymap.set("n", "<Leader>ca", "<cmd>CodeCompanionToggle<cr>", opts("Toggle Code Companion"))
	-- 		vim.keymap.set("v", "<Leader>ca", "<cmd>CodeCompanionToggle<cr>", opts("Toggle Code Companion"))
	-- 		vim.keymap.set("v", "<Leader>ga", "<cmd>CodeCompanionAdd<cr>", opts("Add to Code Companion"))
	--
	-- 		-- Expand 'cc' into 'CodeCompanion' in the command line
	-- 		vim.cmd([[cab cc CodeCompanion]])
	-- 	end,
	-- },
}
