return {
	"lukas-reineke/indent-blankline.nvim",
	event = { 'BufReadPre', 'BufNewFile' },
	opts = {
		show_end_of_line = false,
		space_char_blankline = " ",
		use_treesitter = true,
		show_first_indent_level = false,
		show_trailing_blankline_indent = false,
		show_current_context = true
	}
}
