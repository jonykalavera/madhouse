-- define common options
local opts = function(desc)
	return {
		desc = desc,
		noremap = true, -- non-recursive
		silent = true, -- do not show message
	}
end

-----------------
-- Normal mode --
-----------------

-- Search
vim.keymap.set("n", "<leader>ss", function()
	vim.cmd('let @/ = ""')
end, opts("Clear search")) --

-- Hint: see `:h vim.map.set()`
-- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", opts("Go to left window"))
-- vim.keymap.set("n", "<C-j>", "<C-w>j", opts("Go to lower window"))
-- vim.keymap.set("n", "<C-k>", "<C-w>k", opts("Go to upper window"))
-- vim.keymap.set("n", "<C-l>", "<C-w>l", opts("Go to right window"))

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts("Decrease window height"))
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts("Increase window height"))
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts("Decrease window width"))
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts("Increase window width"))

-- Spelling
vim.keymap.set("n", "<leader>sc", ":set spell!<CR>", opts("Toggle spell check"))

-- Text editing
vim.keymap.set("n", "ya", "ggVGy<C-O>", opts("Copy all text"))
vim.keymap.set("n", "sa", "ggVG<C-O>", opts("Select all text"))
vim.keymap.set("n", "<C-a>", "ggVG<C-O>", opts("Select all text"))
vim.keymap.set("n", "<C-D>", "yyp", opts("Duplicate line"))
-- vim.keymap.set("n", "<C-K>", "dd", opts("Delete line"))

-----------------
-- Visual mode --:
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts("Unindent selection"))
vim.keymap.set("v", ">", ">gv", opts("Indent selection"))

-------------------
-- Terminal mode --:
-------------------

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts("Exit terminal mode"))
