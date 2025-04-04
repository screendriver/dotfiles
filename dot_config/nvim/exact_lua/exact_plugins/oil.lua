return {
	"stevearc/oil.nvim",
	lazy = false,
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
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
