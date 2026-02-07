return {
	"andymass/vim-matchup",
	dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
	config = function()
		vim.g.loaded_matchit = 1 -- Slightly start-up time improvement
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.g.matchup_surround_enabled = 1
		vim.g.matchup_matchparen_deferred = 1
		vim.g.matchup_matchparen_hi_surround_always = 0
	end,
}
