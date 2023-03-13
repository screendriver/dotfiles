return {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{
				"<leader>bf",
				"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
				desc = "[B]rowse [F]iles with path of current buffer",
				noremap = true,
			},
			{
				"<leader>bF",
				"<cmd>Telescope file_browser<CR>",
				desc = "[B]rowse [F]iles",
				noremap = true,
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "[F]ind by [G]rep",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "[F]ind in [B]uffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "[F]ind [H]elp",
			},
			{
				"<leader>fm",
				function()
					require("telescope.builtin").marks()
				end,
				desc = "[F]ind [M]arks",
			},
			{
				"<leader>fk",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "[F]ind [K]eymaps",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{
				"<leader>fc",
				"<cmd>Telescope neoclip<cr>",
				desc = "[F]ind in [C]lipboard",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[F]ind [D]iagnostics",
			},
		},
		opts = {
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "file", "--hidden" },
				},
			},
			extensions = {
				file_browser = {
					grouped = true,
					hidden = true,
					sorting_strategy = "ascending",
					respect_gitignore = false,
					use_fd = true,
				},
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("neoclip")
			telescope.load_extension("coc")
			telescope.load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"AckslD/nvim-neoclip.lua",
		name = "neoclip",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			default_register = "+",
		},
	},
	"fannheyward/telescope-coc.nvim",
}
