vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
vim.opt.signcolumn = "yes"
-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
vim.opt.updatetime = 750
vim.opt.clipboard:append("unnamedplus")
-- Trigger a quick-scope highlight
vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
vim.cmd.colorscheme("dracula")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
