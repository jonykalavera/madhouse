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
				-- api_key_cmd = "op read op://Personal/ChatGPT/password --no-newline",
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
			wk.register({
				c = {
					name = "ChatGPT",
					c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
					e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
					g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
					t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
					k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
					d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
					a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
					o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
					s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
					f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
					x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
					r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
					l = {
						"<cmd>ChatGPTRun code_readability_analysis<CR>",
						"Code Readability Analysis",
						mode = { "n", "v" },
					},
				},
			}, {
				prefix = "<leader>",
				mode = "n",
			})
			wk.register({
				p = {
					name = "ChatGPT",
					e = {
						function()
							chatgpt.edit_with_instructions()
						end,
						"Edit with instructions",
					},
				},
			}, {
				prefix = "<leader>",
				mode = "v",
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
