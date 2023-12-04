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
			"<leader>oi",
			"<cmd>Oil --float<CR>",
			silent = true,
			noremap = true,
			desc = "Open [Oi]l in a floating window",
		},
		{
			"-",
			"<CMD>Oil<CR>",
			noremap = true,
			desc = "Open parent directory",
		},
	},
}
