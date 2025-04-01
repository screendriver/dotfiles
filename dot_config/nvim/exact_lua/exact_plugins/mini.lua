return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.comment").setup()
		require("mini.icons").setup()
	end,
}
