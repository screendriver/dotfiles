local function codium()
	return require("codeium.virtual_text").status_string()
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"Exafunction/codeium.nvim",
		},
		lazy = false,
		opts = {
			options = {
				theme = "dracula-nvim",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { {
					"filename",
					path = 1,
				} },
				lualine_x = {
					codium,
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
}
