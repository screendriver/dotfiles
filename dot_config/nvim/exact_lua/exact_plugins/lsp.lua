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
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"glepnir/lspsaga.nvim",
		},
		config = function()
			local on_attach = function(client, bufnr)
				vim.keymap.set("n", "<space>fo", function()
					vim.lsp.buf.format({ async = true })
				end, { noremap = true, silent = true, buffer = bufnr, desc = "[Fo]rmat current buffer" })
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
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		keys = {
			{ "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "Find the symbol's definition" },
			{ "<leader>ca", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" }, desc = "[C]ode [A]ction" },
			{ "gr", "<cmd>Lspsaga rename<CR>", desc = "[R]ename symbol" },
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "Go to [D]efinition" },
			{ "gt", "<cmd>Lspsaga goto_type_definition<CR>", desc = "Go to [T]ype definiton" },
			{ "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Go to next diagnostics" },
			{ "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Go to previous diagnostics" },
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
		event = "BufReadPost",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint_d.with({
						diagnostics_format = "[eslint] #{m} (#{c})",
					}),
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
}
