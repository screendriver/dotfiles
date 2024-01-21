vim.g.mapleader = " " -- Use <Space> as leader key
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show line number relative to the current line
vim.opt.swapfile = false -- Disable swap file

-- Search
vim.opt.ignorecase = true -- Ignore letter case when searching
vim.opt.smartcase = true -- Case insentive unless capitals used in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Set incremental search, like modern Browsers

vim.opt.cursorline = true -- Find the current line quickly
vim.opt.mouse = "a" -- Enable mouse support

-- Indentation
vim.opt.tabstop = 4 -- 1 Tab = 2 Spaces
vim.opt.shiftwidth = 4 -- shift 4 spaces
vim.opt.autoindent = true -- Copy indent from current line when starting a new line

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

-- Split natural directions
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Error bells
vim.opt.errorbells = false
vim.opt.visualbell = true

vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
vim.opt.updatetime = 350 -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" } -- Trigger a quick-scope highlight
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.opt.termguicolors = true -- Force GUI colors in terminals
vim.opt.iskeyword:append("-") -- Words-with-a-dash should be treated as a whole word

vim.opt.conceallevel = 1 -- Display JSON files without any quotes
