return {
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	keys = {
		{
			"<C-a>",
			mode = { "i" },
			function()
				require("codeium.virtual_text").cycle_or_complete()
			end,
			desc = "Codeium virtual text",
		},
	},
	config = function()
		require("codeium").setup({
			virtual_text = {
				enabled = true,
				manual = true,
				quiet = true,
				key_bindings = {
					accept = "<Tab>",
					next = "<c-.>",
					prev = "<c-,>",
					clear = "<c-x>",
				},
			},
		})
	end,
}
