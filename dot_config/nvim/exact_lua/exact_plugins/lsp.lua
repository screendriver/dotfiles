return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "BufWinEnter" },
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

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local schemastore = require("schemastore")

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

			vim.lsp.enable("vue_ls", { capabilities = capabilities })
			vim.lsp.config("vue_ls", { capabilities = capabilities })

			local vue_language_server_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
			local vue_plugin = {
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
				configNamespace = "typescript",
			}
			vim.lsp.config("vtsls", {
				settings = {
					vtsls = {
						tsserver = {
							globalPlugins = {
								vue_plugin,
							},
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})
			vim.lsp.enable("vtsls")

			local base_on_attach = vim.lsp.config.eslint.on_attach
			vim.lsp.enable("eslint")
			vim.lsp.config("eslint", {
				capabilities = capabilities,

				on_attach = function(client, bufnr)
					if not base_on_attach then
						return
					end

					base_on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "LspEslintFixAll",
					})
				end,
			})

			vim.lsp.enable("astro")
			vim.lsp.config("astro", { capabilities = capabilities })

			vim.lsp.enable("tailwindcss")
			vim.lsp.config("tailwindcss", { capabilities = capabilities })

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
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"mikavilpas/blink-ripgrep.nvim",
			"Exafunction/codeium.nvim",
		},
		opts = {
			enabled = function()
				-- If in the cmdline, enable completion regardless of filetype
				if vim.fn.getcmdtype() ~= "" then
					return true
				end

				-- Disable completion if the current buffer is "oil" or "sagarename"
				return not vim.tbl_contains({ "oil", "sagarename" }, vim.bo.filetype)
			end,
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
