require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"html",
		"css",
		"javascript",
		"typescript",
		"json",
		"gitignore",
		"markdown",
		"svelte",
		"astro",
		"help",
		"lua"
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	}
})
