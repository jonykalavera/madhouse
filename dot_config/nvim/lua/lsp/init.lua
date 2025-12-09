-- load each server config
local servers = {
	"easy_dotnet",
	"eslint",
	"gdscript",
	"harper_ls",
	"lua_ls",
	"marksman",
	"pylsp",
	"ruff",
	"ts_ls",
}

local defaults = {
	on_attach = require("common.handlers").on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

for _, server in ipairs(servers) do
	local ok, conf = pcall(require, "lsp." .. server)
	local config = vim.tbl_deep_extend("force", defaults, conf or {})
	vim.lsp.config(server, conf)
	vim.lsp.enable(server)
end
