return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
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

			vim.lsp.enable("lua_ls")
			vim.lsp.config("lua_ls", { capabilities = capabilities })

			vim.lsp.enable("jsonls")
			vim.lsp.config("jsonls", {
				capabilities = capabilities,
				settings = {
					json = {
						schemas = schemastore.json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.lsp.enable("yamlls")
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
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

			vim.lsp.enable("ts_ls")
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
			})

			lspconfig.volar.setup({ capabilities = capabilities })

			lspconfig.astro.setup({ capabilities = capabilities })

			lspconfig.tailwindcss.setup({ capabilities = capabilities })

			vim.lsp.enable("docker_compose_language_service")
			vim.lsp.config("docker_compose_language_service", { capabilities = capabilities })

			vim.lsp.enable("dockerls")
			vim.lsp.config("dockerls", { capabilities = capabilities })

			vim.lsp.enable("taplo")
			vim.lsp.config("taplo", { capabilities = capabilities })

			vim.lsp.enable("cssls")
			vim.lsp.config("cssls", { capabilities = capabilities })

			vim.lsp.enable("ansiblels")
			vim.lsp.config("ansiblels", { capabilities = capabilities })

			vim.lsp.enable("gopls")
			vim.lsp.config("gopls", { capabilities = capabilities })
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
			{ "neovim/nvim-lspconfig" },
			{ "nvim-tree/nvim-web-devicons" },
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
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
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
						columns = {
							{ "kind_icon", "label", "label_description", gap = 1 },
							{ "kind", "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
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
							ignore_paths = { "package-lock.json" },
						},
						score_offset = -100,
					},
					codeium = { name = "Codeium", module = "codeium.blink", async = true },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
