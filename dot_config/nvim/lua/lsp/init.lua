local M = {}

local DISABLED = {}

local lsp_directory = os.getenv("HOME") .. "/.config/nvim/lua/lsp"

local function get_lsp_servers(directory)
	local filesList = {}
	local p = io.popen('ls "' .. directory .. '"')
	if p == nil then
		return {}
	end
	for file in p:lines() do
		if file:match("%.lua$") and file ~= "init.lua" then -- Exclude `init.lua`
			-- Remove .lua extension
			local nameWithoutExtension = file:gsub("%.lua$", "")
			if not vim.tbl_contains(DISABLED, nameWithoutExtension) then
				table.insert(filesList, nameWithoutExtension) -- Add to the list
			end
		end
	end

	return filesList -- Return the list of filenames without extensions
end

-- Default server config
local defaults = {
	on_attach = require("common.handlers").on_attach,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- Load each server config
M.setup = function()
	local servers = get_lsp_servers(lsp_directory)
	for _, server in ipairs(servers) do
		local _, conf = pcall(require, "lsp." .. server)
		local config = vim.tbl_deep_extend("force", defaults, conf or {})

		-- Use lspconfig setup
		vim.lsp.config(server, config)
		vim.lsp.enable(server)
	end
end

return M
