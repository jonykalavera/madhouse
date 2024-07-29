vim.g.jest_tests_path = vim.fn.getcwd() .. "/timeline-spa"
local chatgpt = require("chatgpt")
chatgpt.setup({
	api_key_cmd = "secret-tool lookup chatgpt apikey",
	actions_paths = { "~/.config/nvim/chatgpt-actions.json" },
})
vim.g.python3_host_prog = "$VIRTUAL_ENV/bin/python3"
