return {
	"akinsho/bufferline.nvim",
	version = "3.*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "BufReadPost",
	opts = {
		options = {
			right_mouse_command = false,
			diagnostics = "nvim_lsp",
			always_show_bufferline = false,
		},
	},
	keys = {
		{ "<leader>gb", "<cmd>BufferLinePick<CR>", silent = true, desc = "[G]o to [B]uffer" },
		{ "<leader>bd", "<cmd>BufferLinePickClose<CR>", silent = true, desc = "[B]uffer [D]elete" },
		{ "]b", "<cmd>BufferLineCycleNext<CR><CR>", silent = true, desc = "Go to next [B]uffer" },
		{ "[b", "<cmd>BufferLineCyclePrev<CR>", silent = true, desc = "Go to previous [B]uffer" },
	},
}
