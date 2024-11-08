return {
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>lg", ":LazyGit<CR>", silent = true, desc = "Open [L]azy[G]it" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {},
	},
	"sindrets/diffview.nvim",
	{
		"akinsho/git-conflict.nvim",
		version = "v2.0.0",
		config = true,
	},
}
