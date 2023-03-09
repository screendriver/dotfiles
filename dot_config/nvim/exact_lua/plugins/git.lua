return {
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>lg", ":LazyGit<CR>", silent = true, desc = "Open [L]azy[G]it" }
		}
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {}
	},
	{
		'akinsho/git-conflict.nvim',
		version = '*',
		event = 'BufReadPost',
		opts = {}
	}
}
