return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		init = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)
		end,
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
				float = {
					source = true,
				},
			})

			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.setup_servers({
				"eslint",
				"astro",
				"svelte",
				"tailwindcss",
				"lua_ls",
				"docker_compose_language_service",
				"dockerls",
				"taplo",
				"cssls",
			})

			local lspconfig = require("lspconfig")

			lspconfig.jsonls.setup({
				settings = {
					json = {
						schemas = require("schemastore").json.schemas({
							select = {
								"package.json",
								"tsconfig.json",
								".eslintrc",
								"Vercel",
								"Renovate",
								"prettierrc.json",
								"Stryker Mutator",
								"AVA Configuration",
								"AWS CDK cdk.json",
								"cspell",
								"Web App Manifest",
								"jscpd Configuration",
							},
							extra = {
								{
									name = "Dependency Cruiser",
									description = "Dependency Cruiser configuration file",
									fileMatch = { "dependency-cruiser.config.json" },
									url = "https://raw.githubusercontent.com/sverweij/dependency-cruiser/main/src/schema/configuration.schema.json",
								},
							},
						}),
						validate = { enable = true },
					},
				},
			})

			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas({
							select = {
								"gitlab-ci",
								"GitHub Workflow",
								"GitHub Action",
								"docker-compose.yml",
							},
						}),
					},
				},
			})

			require("typescript-tools").setup({})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
				},
			})

			local cmp = require("cmp")
			local cmp_action = require("lsp-zero").cmp_action()

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "b0o/schemastore.nvim" },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},
	{ "L3MON4D3/LuaSnip" },
	{ "onsails/lspkind.nvim" },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "VonHeikemen/lsp-zero.nvim", "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "VonHeikemen/lsp-zero.nvim" },
		},
		keys = {
			{ "gf", "<cmd>Lspsaga finder<CR>", desc = "Find the symbol's definition" },
			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "[C]ode [A]ction",
			},
			{ "gr", "<cmd>Lspsaga rename<CR>", desc = "[R]ename symbol" },
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to [D]efinition" },
			{ "gt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to [T]ype definiton" },
			{ "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show [L]ine [D]iagnostics" },
			{ "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show [C]cursor [D]iagnostics" },
			{ "<leader>o", "<cmd>Lspsaga outline<CR>", desc = "Toggle [O]utline" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Go to next [D]iagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Go to previous [D]iagnostics" },
			{ "K", "<cmd>Lspsaga hover_doc<CR>", desc = "Show documentation in preview window" },
		},
		opts = {
			symbol_in_winbar = {
				enable = false,
			},
			diagnostic = {
				on_insert = false,
			},
			ui = {
				border = "rounded",
			},
		},
	},
}
