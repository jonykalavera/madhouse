local M = {}

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = function(desc)
-- 	return { desc = desc, noremap = true, silent = true }
-- end
-- vim.keymap.set("n", "<Leader>de", vim.diagnostic.open_float, opts("Open diagnostics popup"))
-- vim.keymap.set("n", "[d", function()
-- 	vim.diagnostic.jump({ count = -1, float = true })
-- end, opts("Go to previous diagnostic"))
-- vim.keymap.set("n", "]d", function()
-- 	vim.diagnostic.jump({ count = 1, float = true })
-- end, opts("Go to next diagnostic"))
-- vim.keymap.set(
-- 	"n",
-- 	"<leader>dq",
-- 	vim.diagnostic.setloclist,
-- 	opts("Add buffer diagnostics to the location list.")
-- )
--
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = function(desc)
		return { desc = "LSP / " .. desc, noremap = true, silent = true, buffer = bufnr }
	end
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Show hover information"))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Show implentations"))
	vim.keymap.set("n", "H", vim.lsp.buf.signature_help, bufopts("Show signature help"))
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts("Add workspace folder"))
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts("Remove workspace folder"))
	vim.keymap.set("n", "<Leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts("Show all workspace folders"))
	vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts("Rename globally"))
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts("Show code actions"))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Show references"))
	-- vim.keymap.set("n", "<Leader>f", function()
	-- 	vim.lsp.buf.format({ async = true })
	-- end, bufopts("Format buffer"))

	-- CS Projects
	local FixProjectSlashes = function()
		for _, f in ipairs(vim.fn.glob("**/*.{csproj,props,targets,slnx}", true, true)) do
			vim.cmd("edit " .. vim.fn.fnameescape(f))
			vim.cmd([[%s#\\#/#ge]])
			vim.cmd("update")
		end
	end
	vim.api.nvim_create_user_command("FixProjectSlashes", FixProjectSlashes, {})
	vim.keymap.set(
		"n",
		"<leader>ps",
		":FixProjectSlashes<CR>",
		{ silent = true, noremap = true, desc = "Fix project slashes" }
	)
end
return M
