return {
	"akinsho/bufferline.nvim",
	version = "3.*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
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
		{ "<C-n>", "<cmd>BufferLineCycleNext<CR><CR>", silent = true, desc = "Go to [N]next Buffer" },
		{ "<C-p>", "<cmd>BufferLineCyclePrev<CR>", silent = true, desc = "Go to [P]revious Buffer" },
	},
}
