-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("lazy").setup("plugins")
-- quickfix list delete keymap
function Remove_qf_item()
	local curqfidx = vim.fn.line(".")
	local qfall = vim.fn.getqflist()

	-- Return if there are no items to remove
	if #qfall == 0 then
		return
	end

	-- Remove the item from the quickfix list
	table.remove(qfall, curqfidx)
	vim.fn.setqflist(qfall, "r")

	-- Reopen quickfix window to refresh the list
	vim.cmd("copen")

	-- If not at the end of the list, stay at the same index, otherwise, go one up.
	local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

	-- Set the cursor position directly in the quickfix window
	local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
	vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

vim.cmd("command! RemoveQFItem lua Remove_qf_item()")
vim.api.nvim_command("autocmd FileType qf nnoremap <buffer> dd :RemoveQFItem<cr>")

require("keymaps")
require("colorscheme")
vim.opt.spell = true
vim.opt.spelllang = "en_us"
