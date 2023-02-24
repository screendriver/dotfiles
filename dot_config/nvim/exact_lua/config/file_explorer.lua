local nnn = require("nnn")

nnn.setup({
	explorer = {
		cmd = "nnn -o"
	},
	mappings = {
		{ "<C-t>", nnn.builtin.open_in_tab },
		{ "<C-s>", nnn.builtin.open_in_split },
		{ "<C-v>", nnn.builtin.open_in_vsplit },
		{ "<C-p>", nnn.builtin.open_in_preview },
		{ "<C-y>", nnn.builtin.copy_to_clipboard },
	}
})

vim.keymap.set("n", "<leader>nn", "<cmd>NnnPicker<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>n", "<cmd>NnnPicker %:p:h<CR>", { noremap = true })
