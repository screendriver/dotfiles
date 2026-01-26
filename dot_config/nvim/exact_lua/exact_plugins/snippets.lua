return {
	{
		"L3MON4D3/LuaSnip",
		version = "*",
		build = "make install_jsregexp",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/nvim-cmp",
		},
	},
}
