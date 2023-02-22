-- Open nvim-tree for directories at Neovim startup
require("nvim-tree").setup({
	diagnostics = {
		enable = true
	},
	modified = {
		enable = true
	},
	renderer = {
		highlight_opened_files = "name",
	}
})

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.keymap.set("n", "<leader>tt", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

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
