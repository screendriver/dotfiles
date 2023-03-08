return {
	"luukvbaal/nnn.nvim",
	opts = {
		explorer = {
			cmd = "nnn -o"
		},
	},
	config = function()
		local nnn = require("nnn")

		nnn.setup({
			mappings = {
				{ "<C-t>", nnn.builtin.open_in_tab },
				{ "<C-s>", nnn.builtin.open_in_split },
				{ "<C-v>", nnn.builtin.open_in_vsplit },
				{ "<C-p>", nnn.builtin.open_in_preview },
				{ "<C-y>", nnn.builtin.copy_to_clipboard },
			}
		})
	end,
	keys = {
		{ "<leader>nn", "<cmd>NnnPicker<CR>",       silent = true,  noremap = true,                       desc = "Open [Nn]n" },
		{ "<leader>np", "<cmd>NnnPicker %:p:h<CR>", noremap = true, desc = "Open [N]nn in current [P]ath" }
	}
}
