return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			local parsers = {
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
				"vue",
				"just",
				"graphql",
				"go",
				"gomod",
				"scss",
			}

			for _, parser in ipairs(parsers) do
				ts.install(parser)
			end

			-- Collect file type patterns for autocommand
			local patterns = {}
			for _, parser in ipairs(parsers) do
				local parser_patterns = vim.treesitter.language.get_filetypes(parser)
				for _, pp in pairs(parser_patterns) do
					table.insert(patterns, pp)
				end
			end

			-- Enable treesitter features via autocommand
			vim.api.nvim_create_autocmd("FileType", {
				pattern = patterns,
				callback = function()
					-- Disable for chezmoitmpl files
					if string.find(vim.bo.filetype, "chezmoitmpl") then
						return
					end

					-- Enable syntax highlighting
					vim.treesitter.start()

					-- Enable indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			-- Set up treesitter-context
			require("treesitter-context").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
		config = function()
			-- Set up textobjects module
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@function.outer"] = "V",
						["@parameter.inner"] = "v",
					},
					include_surrounding_whitespace = false,
				},
				swap = {
					enable = true,
				},
			})

			-- Set up select keymaps
			vim.keymap.set({ "x", "o" }, "af", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end, { desc = "Select [A]round [F]unction" })

			vim.keymap.set({ "x", "o" }, "if", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end, { desc = "Select [I]n [F]unction" })

			-- Set up swap keymaps (skip for dart files)
			local function setup_swap_keymaps()
				if vim.bo.filetype == "dart" then
					return
				end

				vim.keymap.set("n", "<leader>a", function()
					require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
				end, { buffer = true, desc = "Swap with next parameter" })

				vim.keymap.set("n", "<leader>A", function()
					require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
				end, { buffer = true, desc = "Swap with previous parameter" })
			end

			-- Set up swap keymaps for non-dart files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = setup_swap_keymaps,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", branch = "main" },
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
}
