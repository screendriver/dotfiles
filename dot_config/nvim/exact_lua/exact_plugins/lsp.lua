return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"echasnovski/mini.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {},
			})

			local lspconfig = require("lspconfig")

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local schemastore = require("schemastore")
			local vue_language_server_path = require("mason-registry")
				.get_package("vue-language-server")
				:get_install_path() .. "/node_modules/@vue/language-server"

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.jsonls.setup({
				settings = {
					json = {
						schemas = schemastore.json.schemas(),
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
						schemas = schemastore.yaml.schemas({
							extra = {
								{
									description = "Configuration profiles manager for restic backup",
									fileMatch = "profiles.yaml",
									name = "profiles.yaml",
									url = "https://creativeprojects.github.io/resticprofile/jsonschema/config-1.json",
								},
							},
						}),
					},
				},
			})

			lspconfig.ts_ls.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			lspconfig.astro.setup({
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})

			lspconfig.docker_compose_language_service.setup({
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})

			lspconfig.taplo.setup({
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			lspconfig.volar.setup({
				capabilities = capabilities,
			})

			lspconfig.ansiblels.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
			{ "neovim/nvim-lspconfig" },
		},
		keys = {
			{
				"<leader>ca",
				"<cmd>Lspsaga code_action<CR>",
				mode = { "n", "v" },
				desc = "Code action",
			},
			{ "<leader>rs", "<cmd>Lspsaga rename<CR>", desc = "Rename symbol" },
			{ "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "Show line diagnostics" },
			{ "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", desc = "Show ccursor diagnostics" },
			{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Go to next diagnostics" },
			{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Go to previous diagnostics" },
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
			rename = {
				in_select = false,
				auto_save = true,
			},
		},
		config = function(_, opts)
			-- Patch to use mini.icons
			require("lspsaga.util").icon_from_devicon = function(ft)
				return require("mini.icons").get("filetype", ft)
			end

			require("lspsaga").setup(opts)
		end,
	},
	{
		"saghen/blink.compat",
		lazy = true,
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"mikavilpas/blink-ripgrep.nvim",
			"Exafunction/codeium.nvim",
		},
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			completion = {
				keyword = { range = "prefix" },
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				list = { selection = { preselect = true, auto_insert = true } },
			},
			sources = {
				default = { "lsp", "path", "buffer", "ripgrep", "codeium" },
				providers = {
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {
							project_root_marker = { ".git", "package.json" },
						},
					},
					codeium = {
						name = "codeium",
						module = "blink.compat.source",
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
