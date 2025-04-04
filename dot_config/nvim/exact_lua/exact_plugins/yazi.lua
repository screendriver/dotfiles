---@type LazySpec
return {
	"mikavilpas/yazi.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "VeryLazy",
	-- stylua: ignore
	keys = {
		{ "<leader>yy", function() require("yazi").yazi() end, desc = "Open Yazi file manager", },
		{ "<leader>cw", function() require("yazi").yazi(nil, vim.fn.getcwd()) end, desc = "Open Yazi file manager in nvim's working directory", },
	},
	---@type YaziConfig
	opts = {
		open_for_directories = false,
	},
}
