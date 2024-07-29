-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in Nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.autoread = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = false -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.opt.colorcolumn = "120" -- set vertical line marker
vim.opt.showmode = false -- we are experienced, we don't need the "-- INSERT --" mode hint
vim.opt.signcolumn = "yes" -- always show signcolumns
vim.opt.list = true
vim.opt.listchars = "tab:» ,lead:•,trail:•"

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true -- highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered
vim.opt.inccommand = "split" -- "for incsearch while sub

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel,noplainbuffer"

-- Python defaults
vim.g.python3_host_prog = "~/.config/nvim/venv/bin/python"
