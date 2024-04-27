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
				"markdown_inline",
				"astro",
				"vimdoc",
				"lua",
				"yaml",
				"nix",
				"bash",
				"dockerfile",
				"toml",
				"terraform",
				"dart",
			},
			highlight = {
				enable = true,
				disable = function()
					if string.find(vim.bo.filetype, "chezmoitmpl") then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},
			autotag = {
				enable = true,
			},
			matchup = {
				enable = true,
				disable_virtual_text = true,
			},
			textobjects = {
				select = {
					enable = true,
					disable = { "dart" },
					lookahead = true,
					keymaps = {
						["af"] = { query = "@function.outer", desc = "Select [A]round [F]unction" },
						["if"] = { query = "@function.inner", desc = "Select [I]n [F]unction" },
					},
				},
				swap = {
					enable = true,
					disable = { "dart" },
					swap_next = {
						["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
					},
					swap_previous = {
						["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
					},
				},
			},
		},
		config = function(plugin, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("treesitter-context").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
}
