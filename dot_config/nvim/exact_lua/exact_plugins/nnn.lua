return {
	"luukvbaal/nnn.nvim",
	event = "VeryLazy",
	config = function()
		local nnn = require("nnn")

		nnn.setup({
			explorer = {
				cmd = "nnn -G",
			},
			picker = {
				cmd = "nnn -G",
				fullscreen = false,
				style = {
					border = "rounded",
				},
			},
			mappings = {
				{ "<C-t>", nnn.builtin.open_in_tab },
				{ "<C-s>", nnn.builtin.open_in_split },
				{ "<C-v>", nnn.builtin.open_in_vsplit },
				{ "<C-p>", nnn.builtin.open_in_preview },
				{ "<C-y>", nnn.builtin.copy_to_clipboard },
			},
		})
	end,
	keys = {
		{
			"<leader>nN",
			"<cmd>NnnPicker<CR>",
			silent = true,
			noremap = true,
			desc = "Open [Nn]n",
		},
		{ "<leader>nn", "<cmd>NnnPicker %:p:h<CR>", noremap = true, desc = "Open [N]nn in current [P]ath" },
	},
}
