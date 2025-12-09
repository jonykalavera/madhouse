-- Estado para el toggle del autoread
local autoread_enabled = true
local autoread_group = vim.api.nvim_create_augroup("AutoreadGroup", { clear = true })

-- Función para configurar los autocmds
local function setup_autoread()
	if autoread_enabled then
		-- Activar `autoread` cuando los archivos cambien en disco
		vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
			group = autoread_group,
			pattern = "*",
			callback = function()
				local mode = vim.api.nvim_get_mode().mode
				local cmdtype = vim.fn.getcmdwintype()
				if not mode:match("[crRt!]") and cmdtype == "" then
					vim.cmd("checktime")
				end
			end,
		})

		-- Notificación después de cambio de archivo
		vim.api.nvim_create_autocmd("FileChangedShellPost", {
			group = autoread_group,
			pattern = "*",
			callback = function()
				vim.api.nvim_echo({ { "File changed on disk. Buffer reloaded.", "WarningMsg" } }, true, {})
			end,
		})
	else
		-- Limpiar todos los autocmds del grupo
		vim.api.nvim_clear_autocmds({ group = autoread_group })
	end
end

-- Configurar autoread al inicio
setup_autoread()

-- Keymap para toggle
vim.keymap.set("n", "<leader>al", function()
	autoread_enabled = not autoread_enabled
	setup_autoread()
	local status = autoread_enabled and "enabled" or "disabled"
	vim.api.nvim_echo({ { "Autoread " .. status, "Normal" } }, true, {})
end, { desc = "Toggle autoread" })
