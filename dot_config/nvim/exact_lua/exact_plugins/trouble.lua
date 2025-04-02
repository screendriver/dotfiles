return {
	"folke/trouble.nvim",
	event = "VeryLazy",
	opts = {
		mode = "document_diagnostics",
	},
	-- stylua: ignore
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
	},
}
