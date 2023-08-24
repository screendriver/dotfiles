return {
	"mrjones2014/smart-splits.nvim",
	version = "1.x",
	build = "./kitty/install-kittens.bash",
	config = function()
		local set = vim.keymap.set
		local smartSplits = require("smart-splits")

		set("n", "<C-h>", smartSplits.move_cursor_left, { desc = "Jump to left split window" })
		set("n", "<C-j>", smartSplits.move_cursor_down, { desc = "Jump to bottom split window" })
		set("n", "<C-k>", smartSplits.move_cursor_up, { desc = "Jump to top split window" })
		set("n", "<C-l>", smartSplits.move_cursor_right, { desc = "Jump to right split window" })
	end,
}
