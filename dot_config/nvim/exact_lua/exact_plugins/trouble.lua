return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	opts = {
		mode = "document_diagnostics",
	},
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", silent = true, noremap = true, desc = "Toggle Trouble" },
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			silent = true,
			noremap = true,
			desc = "Toggle Trouble workspace diagnostics",
		},
		{
			"<leader>xd",
			"<cmd>TroubleToggle document_diagnostics<cr>",
			silent = true,
			noremap = true,
			desc = "Toggle Trouble document diagnostics",
		},
	},
}
