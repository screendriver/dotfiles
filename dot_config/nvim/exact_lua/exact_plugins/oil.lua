return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		view_options = { show_hidden = true },
	},
	-- stylua: ignore
	keys = {
		{ "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil", },
	}
,
}
