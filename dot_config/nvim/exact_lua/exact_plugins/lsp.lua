return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs",
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

			local on_attach = function(client, bufnr)
				-- Highlight symbol under cursor
				if client.server_capabilities.documentHighlightProvider then
					vim.cmd([[
					  hi! LspReferenceRead cterm=bold ctermbg=red guibg=#6272a4
					  hi! LspReferenceText cterm=bold ctermbg=red guibg=#6272a4
					  hi! LspReferenceWrite cterm=bold ctermbg=red guibg=#6272a4
					]])
					vim.api.nvim_create_augroup("lsp_document_highlight", {
						clear = false,
					})
					vim.api.nvim_clear_autocmds({
						buffer = bufnr,
						group = "lsp_document_highlight",
					})
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = "lsp_document_highlight",
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
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
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.docker_compose_language_service.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.taplo.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.volar.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.ansiblels.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		commit = "13b3cdc9a53ec821b9e693ee71501cc2d6cf206c",
		event = "LspAttach",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
			{ "neovim/nvim-lspconfig" },
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
			rename = {
				in_select = false,
				auto_save = true,
			},
		},
	},
	{
		"saghen/blink.compat",
		lazy = true,
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
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
				default = { "lsp", "path", "buffer", "codeium" },
				providers = {
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
