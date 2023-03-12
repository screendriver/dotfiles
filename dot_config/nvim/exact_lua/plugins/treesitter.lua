return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"git_config",
				"gitattributes",
				"gitcommit",
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
				disable = { "lua" },
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<cr>',
					node_incremental = '<tab>',
					node_decremental = '<s-tab>',
					scope_incremental = '<cr>',
				},
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
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter"
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter"
	},
}
