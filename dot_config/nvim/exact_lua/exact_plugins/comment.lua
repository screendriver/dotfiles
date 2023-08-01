return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	opts = {
		ignore = "^$",
	},
	config = function(pluginName, opts)
		require("Comment").setup(opts)
	end,
}
