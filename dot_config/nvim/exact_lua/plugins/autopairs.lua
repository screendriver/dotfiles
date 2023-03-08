return {
	"windwp/nvim-autopairs",
	lazy = false,
	opts = {
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- it will not add a pair on that treesitter node
			javascript = { 'template_string' },
			java = false, -- don't check treesitter on java
		},
		map_cr = false
	},
	keys = {
		{
			"<CR>",
			function()
				if vim.fn["coc#pum#visible"]() ~= 0 then
					return vim.fn["coc#pum#confirm"]()
				else
					return require("nvim-autopairs").autopairs_cr()
				end
			end,
			mode = "i",
			expr = true,
			noremap = true
		}
	}
}
