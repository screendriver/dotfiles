return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			default_file_explorer = true,
			columns = {
				"icon",
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
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			{
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				desc = "Open Yazi file manager",
			},
			{
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open Yazi file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
}
