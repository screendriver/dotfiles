return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"gitignore",
				"markdown",
				"svelte",
				"astro",
				"help",
				"lua",
				"yaml",
				"nix",
				"bash",
				"dockerfile"
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true
			},
			autotag = {
				enable = true,
			},
			matchup = {
				enable = true
			}
		},
		config = function(plugin, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("treesitter-context").setup()
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter"
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter"
	},
}
