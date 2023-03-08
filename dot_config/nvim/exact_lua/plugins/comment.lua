return {
	"terrortylor/nvim-comment",
	event = "VeryLazy",
	config = function()
		require("nvim_comment").setup({ comment_empty = false })
	end
}
