local M = {}

-- add servers here.
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

-- Default server config
local defaults = {
	on_attach = require("common.handlers").on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- Load each server config
M.setup = function()
	for _, server in ipairs(servers) do
		local _, conf = pcall(require, "lsp." .. server)
		local config = vim.tbl_deep_extend("force", defaults, conf or {})
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end

return M
