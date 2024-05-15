return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local cspellNamespace = lint.get_namespace("cspell")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			vue = { "eslint_d" },
		}

		lint.linters.cspell.args = {
			"lint",
			"--no-color",
			"--no-progress",
			"--no-summary",
			"--config",
			vim.fn.expand("~/.config/cspell/cspell.config.json"),
		}
		vim.diagnostic.config({ virtual_text = false }, cspellNamespace)

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function(ev)
				lint.try_lint()
				if ev.event ~= "BufEnter" then
					lint.try_lint("cspell")
				end
			end,
		})
	end,
}
