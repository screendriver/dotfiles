local telescope = require("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key"
			}
		}
	},
	extensions = {
		file_browser = {
			grouped = true,
			hidden = true,
			sorting_strategy = "ascending"
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
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind in [B]uffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "[F]ind [M]arks" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope neoclip<cr>", { desc = "[F]ind in [C]lipboard" })

telescope.load_extension("fzf")
telescope.load_extension("neoclip")
telescope.load_extension("file_browser")
