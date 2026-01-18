vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true }) -- Move cursor to center of window when scrolling down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true }) -- Move cursor to center of window when scrolling up
vim.keymap.set("n", "n", "nzzzv") -- Move cursor to center of window when searching next
vim.keymap.set("n", "N", "Nzzzv") -- Move cursor to center of window when searching previous

-- Copy a Buffer's relative file path to clipboard
vim.keymap.set(
	"n",
	"<leader>cf",
	"<cmd>let @+ = expand('%')<CR>",
	{ desc = "[C]opy a Buffer's relative [F]ile path to clipboard" }
)
-- Copy a Buffer's absolute file path to clipboard
vim.keymap.set(
	"n",
	"<leader>cF",
	"<cmd>let @+ = expand('%:p')<CR>",
	{ desc = "[C]opy a Buffer's absolute [F]ile path to clipboard" }
)

vim.keymap.set("n", "<leader>h", ":nohl<CR>", { silent = true, desc = "Clear search [H]ighlighting" })

-- LSP

vim.keymap.set("n", "<leader>rs", function()
	vim.lsp.buf.rename()
end, { desc = "[R]ename [S]ymbol" })

vim.keymap.set("n", "<leader>ld", function()
	vim.diagnostic.open_float(nil, { border = "rounded", source = "always", prefix = "" })
end, { desc = "[L]ist [D]iagnostics" })

vim.keymap.set({ "n", "v" }, "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "[C]ode [A]ction" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Show documentation" })
