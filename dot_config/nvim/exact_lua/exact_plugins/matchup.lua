return {
	"andymass/vim-matchup",
	config = function()
		vim.g.loaded_matchit = 1 -- Slightly start-up time improvement
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.g.matchup_surround_enabled = 1
	end,
}
