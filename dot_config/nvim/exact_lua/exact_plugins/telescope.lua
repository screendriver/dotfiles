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
			{
				"<leader>fj",
				function()
					require("telescope.builtin").jumplist()
				end,
				desc = "[F]ind [J]umplist entries",
			},
		},
		opts = {
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "file", "--hidden" },
				},
			},
		},
		config = function(pluginName, opts)
			local telescope = require("telescope")

			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("neoclip")
			telescope.load_extension("ui-select")
		end,
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
	{
		"piersolenski/telescope-import.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("import")
		end,
	},
}
