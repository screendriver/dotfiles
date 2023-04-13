local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"nvimdev/lspsaga.nvim",
		},
		config = function()
			local on_attach = function(client, bufnr)
				-- Format current buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end, { desc = "Format current buffer" })
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

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			lspconfig.tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
			})

			lspconfig.astro.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.g.markdown_fenced_languages = { "ts=typescript" }
			lspconfig.denols.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			})

			lspconfig.svelte.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.marksman.setup({
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

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = {
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "./gitlab-ci.yml",
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
						},
					},
				},
			})

			lspconfig.taplo.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			--Enable (broadcasting) snippet capability for completion
			local snippetCapabilities = vim.lsp.protocol.make_client_capabilities()
			snippetCapabilities.textDocument.completion.completionItem.snippetSupport = true
			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = snippetCapabilities,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")

						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")

						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "BufRead",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		keys = {
			{ "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "Find the symbol's definition" },
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
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "BufReadPost",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				fallback_severity = vim.diagnostic.severity.HINT,
				sources = {
					null_ls.builtins.code_actions.cspell,
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.diagnostics.eslint_d.with({
						diagnostics_format = "[eslint] #{m} (#{c})",
					}),
					null_ls.builtins.diagnostics.cspell.with({
						diagnostic_config = {
							virtual_text = false,
						},
						extra_args = { "--config", vim.fn.expand("~/.config/cspell/cspell.config.json") },
					}),
					null_ls.builtins.formatting.prettierd.with({
						extra_filetypes = { "astro", "svelte" },
					}),
					null_ls.builtins.formatting.stylua,
				},
				on_attach = function(client, bufnr)
					-- Format files on save
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(client)
										return client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = {
			ensure_installed = nil,
			automatic_installation = true,
			automatic_setup = false,
		},
	},
}
