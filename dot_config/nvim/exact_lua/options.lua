local g = vim.g
local opt = vim.opt

g.mapleader = " " -- Use <Space> as leader key
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show line number relative to the current line
opt.swapfile = false -- Disable swap file

-- Search
opt.ignorecase = true -- Ignore letter case when searching
opt.smartcase = true -- Case insentive unless capitals used in search
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Set incremental search, like modern Browsers

opt.cursorline = true -- Find the current line quickly
opt.mouse = "a" -- Enable mouse support

-- Indentation
opt.tabstop = 4 -- 1 Tab = 4 Spaces
opt.shiftwidth = 4 -- shift 4 spaces
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.smartindent = false -- Don't smart autoindenting when starting a new line. Treesitter is doing that for us
opt.expandtab = false -- Don't insert <Tab> when too many spaces are inserted

opt.list = true
opt.listchars:append("space:⋅")

-- Split natural directions
opt.splitright = true
opt.splitbelow = true

-- Error bells
opt.errorbells = false
opt.visualbell = true

opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
opt.updatetime = 350 -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
g.qs_highlight_on_keys = { "f", "F", "t", "T" } -- Trigger a quick-scope highlight
g.loaded_netrw = true
g.loaded_netrwPlugin = true
opt.termguicolors = true -- Force GUI colors in terminals
opt.iskeyword:append("-") -- Words-with-a-dash should be treated as a whole word

opt.conceallevel = 1 -- Display JSON files without any quotes
