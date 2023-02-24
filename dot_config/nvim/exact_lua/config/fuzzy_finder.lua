local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key"
			}
		}
	},
})

require("neoclip").setup({
	default_register = "+",
})

vim.keymap.set(
	"n",
	"<leader>bf",
	telescope.extensions.file_browser.file_browser,
	{ noremap = true, desc = "File Browser" }
)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})

telescope.load_extension("fzf")
telescope.load_extension("neoclip")
telescope.load_extension("file_browser")
