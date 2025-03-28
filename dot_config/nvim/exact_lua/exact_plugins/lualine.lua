local function codium()
	return require("codeium.virtual_text").status_string()
end

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"echasnovski/mini.nvim",
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
		config = function(_, opts)
			require("mini.icons").mock_nvim_web_devicons()

			require("lualine").setup(opts)
		end,
	},
}
