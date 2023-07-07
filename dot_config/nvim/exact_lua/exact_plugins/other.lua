return {
	"rgroli/other.nvim",
	event = "VeryLazy",
	opts = {
		mappings = {
			{
				context = "test",
				pattern = "(.*).ts$",
				target = "%1.test.ts",
			},
			{
				context = "implementation",
				pattern = "(.*).test.ts$",
				target = "%1.ts",
			},
		},
	},
	config = function(plugin, opts)
		require("other-nvim").setup(opts)
	end,
}
