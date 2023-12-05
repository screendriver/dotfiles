return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		default_file_explorer = true,
		columns = {
			"icon",
		},
		buf_options = {
			buflisted = true,
		},
		view_options = {
			show_hidden = true,
		},
		float = {
			win_options = {
				winblend = 3,
			},
		},
	},
	keys = {
		{
			"-",
			"<CMD>Oil<CR>",
			noremap = true,
			desc = "Open parent directory",
		},
	},
}
