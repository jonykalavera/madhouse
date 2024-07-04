vim.g.jest_tests_path = vim.fn.getcwd() .. "/timeline-spa"
local chatgpt = require("chatgpt")
chatgpt.setup({
	api_key_cmd = "op read op://Personal/ChatGPT/password --no-newline",
	actions_paths = { "~/.config/nvim/chatgpt-actions.json" },
})
