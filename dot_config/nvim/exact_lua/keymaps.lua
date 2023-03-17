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
