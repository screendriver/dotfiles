vim.g.mapleader = " " -- Use <Space> as leader key
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show line number relative to the current line

-- Search
vim.opt.ignorecase = true -- Ignore letter case when searching
vim.opt.smartcase = true -- Case insentive unless capitals used in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Set incremental search, like modern Browsers

vim.opt.cursorline = true -- Find the current line quickly
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.title = true -- Show title at top of the terminal
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Indentation
vim.opt.tabstop = 4 -- 1 Tab = 2 Spaces
vim.opt.shiftwidth = 4 -- shift 4 spaces
vim.opt.autoindent = true -- Copy indent from current line when starting a new line

vim.opt.list = true

-- Split natural directions
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Error bells
vim.opt.errorbells = false
vim.opt.visualbell = true

vim.opt.signcolumn =
"yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
vim.opt.updatetime = 750 -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" } -- Trigger a quick-scope highlight
vim.cmd.colorscheme("dracula")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true -- Force GUI colors in terminals

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true }) -- Move cursor to center of window when scrolling down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true }) -- Move cursor to center of window when scrolling up
vim.keymap.set("n", "n", "nzzzv") -- Move cursor to center of window when searching next
vim.keymap.set("n", "N", "Nzzzv") -- Move cursor to center of window when searching previous

vim.keymap.set("n", "<leader>cf", "<cmd>let @+ = expand('%')<CR>",
	{ desc = "[C]opy a Buffer's relative [F]ile path to clipboard" }) -- Copy a Buffer's relative file path to clipboard
vim.keymap.set("n", "<leader>cF", "<cmd>let @+ = expand('%:p')<CR>",
	{ desc = "[C]opy a Buffer's absolute [F]ile path to clipboard" }) -- Copy a Buffer's absolute file path to clipboard
