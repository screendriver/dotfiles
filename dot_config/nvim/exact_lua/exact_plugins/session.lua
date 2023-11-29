return {
	"olimorris/persisted.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		use_git_branch = false,
		autosave = true,
		autoload = true,
	},
	config = function(pluginName, opts)
		require("persisted").setup(opts)
		require("telescope").load_extension("persisted")
	end,
}
