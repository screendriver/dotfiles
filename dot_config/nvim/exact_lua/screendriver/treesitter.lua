require("nvim-treesitter.configs").setup({
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
		"gitignore",
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
})

require("treesitter-context").setup()
