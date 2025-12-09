-- load each server config
local servers = {
	"easy_dotnet",
	"lua_ls",
	"pylsp",
}

for _, server in ipairs(servers) do
	local ok, conf = pcall(require, "lsp." .. server)
	if ok then
		vim.lsp.config(server, conf)
		vim.lsp.enable(server)
	end
end
