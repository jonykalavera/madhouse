return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local handlers = require("common.handlers")
			require("easy-dotnet").setup({
				lsp = {
					config = { on_attach = handlers.on_attach },
				},
				debugger = {
					--name if netcoredbg is in PATH or full path like 'C:\Users\gusta\AppData\Local\nvim-data\mason\bin\netcoredbg.cmd'
					bin_path = "netcoredbg",
				},
			})
			-- -- Customize DAP config
			-- -- Este código debe ejecutarse DESPUÉS de que easy-dotnet.nvim haya configurado nvim-dap.
			-- local dap = require("dap")
			--
			-- -- Verifica si la configuración de C# existe y tiene al menos un perfil
			-- if dap.configurations.cs and #dap.configurations.cs > 0 then
			-- 	-- Asumimos que el primer perfil de configuración es el que usa easy-dotnet.nvim
			-- 	local config = dap.configurations.cs[1]
			--
			-- 	-- 1. Deshabilita 'Just My Code' para permitir el paso a código externo
			-- 	config.justMyCode = false
			--
			-- 	-- 2. (Opcional pero recomendado) Asegura que el depurador busque símbolos
			-- 	-- en el servidor de símbolos de Microsoft para descargar el código fuente.
			-- 	if not config.symbolSearchPaths then
			-- 		config.symbolSearchPaths = {}
			-- 	end
			-- 	table.insert(config.symbolSearchPaths, "https://msdl.microsoft.com/download/symbols")
			--
			-- 	-- Si easy-dotnet.nvim usa un nombre de perfil específico, puedes buscarlo por nombre
			-- 	-- en lugar de usar el índice [1].
			-- 	vim.notify("Custom DAP config applied.", vim.log.levels.INFO)
			-- end
		end,
	},
}
