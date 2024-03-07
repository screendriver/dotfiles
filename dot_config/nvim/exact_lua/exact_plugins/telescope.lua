local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

return {
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"telescope-fzf-native.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"akinsho/flutter-tools.nvim",
			{ "nvim-telescope/telescope-live-grep-args.nvim", version = "1.x" },
			"debugloop/telescope-undo.nvim",
		},
		keys = {
			{
				"<leader>ff",
				function()
					builtin.find_files()
				end,
				desc = "[F]ind [F]iles",
			},
			{
				"<leader>fg",
				function()
					telescope.extensions.live_grep_args.live_grep_args()
				end,
				desc = "[F]ind by [G]rep with arguments",
			},
			{
				"<leader>fw",
				function()
					builtin.grep_string()
				end,
				desc = "[F]ind [W]ord under cursor",
			},
			{
				"<leader>fb",
				function()
					builtin.buffers()
				end,
				desc = "[F]ind in [B]uffers",
			},
			{
				"<leader>fr",
				function()
					builtin.registers()
				end,
				desc = "[F]ind in [R]egisters",
			},
			{
				"<leader>fh",
				function()
					builtin.help_tags()
				end,
				desc = "[F]ind [H]elp",
			},
			{
				"<leader>fm",
				function()
					builtin.marks()
				end,
				desc = "[F]ind [M]arks",
			},
			{
				"<leader>fk",
				function()
					builtin.keymaps()
				end,
				desc = "[F]ind [K]eymaps",
			},
			{
				"<leader>/",
				function()
					builtin.current_buffer_fuzzy_find()
				end,
				desc = "[/] Fuzzily search in current buffer",
			},
			{
				"<leader>fd",
				function()
					builtin.diagnostics()
				end,
				desc = "[F]ind [D]iagnostics",
			},
			{
				"<leader>fj",
				function()
					builtin.jumplist()
				end,
				desc = "[F]ind [J]umplist entries",
			},
			{
				"<leader>u",
				function()
					telescope.extensions.undo.undo()
				end,
				desc = "[U]ndo history",
			},
		},
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-h>"] = "which_key",
					},
				},
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							["<C-b>"] = actions.delete_buffer,
						},
					},
				},
				find_files = {
					find_command = { "fd", "--type", "file", "--hidden" },
				},
			},
			extensions = {
				undo = {
					use_delta = true,
					side_by_side = false,
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.7,
						},
					},
				},
			},
		},
		config = function(pluginName, opts)
			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("flutter")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("undo")
			telescope.load_extension("persisted")
		end,
	},
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"piersolenski/telescope-import.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			telescope.load_extension("import")
		end,
	},
}
