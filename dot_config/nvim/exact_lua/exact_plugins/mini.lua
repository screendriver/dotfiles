return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup()
		require("mini.diff").setup()
		require("mini.pairs").setup()
	end,
}
