return {
	"lukas-reineke/indent-blankline.nvim",
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		show_end_of_line = false,
		space_char_blankline = " ",
	}
}
