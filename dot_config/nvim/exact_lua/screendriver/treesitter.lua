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
		"lua",
		"nix"
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
})
