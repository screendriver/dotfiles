return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	opts = {
		ignore = "^$",
	},
	config = function(pluginName, opts)
		require("Comment").setup(opts)

		local ft = require("Comment.ft")
		ft.set("astro", "<!--%s-->")
	end,
}
