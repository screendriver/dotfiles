return {
	"folke/zen-mode.nvim",
	events = "VeryLazy",
	opts = {
		window = {
			options = {
				signcolumn = "no",
				number = true,
				relativenumber = true
			}
		},
		plugins = {
			kitty = {
				enabled = true,
				font = "+4"
			}
		}
	}
}
