return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { {
					"filename",
					path = 1
				} },
				lualine_x = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
					"filetype"
				},
				lualine_y = { "progress" },
				lualine_z = { "location" }
			},
		}
	},
}
