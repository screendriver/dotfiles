return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		local cspellNamespace = lint.get_namespace("cspell")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			vue = { "eslint" },
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

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				lint.try_lint()
				lint.try_lint("cspell")
			end,
		})
	end,
}
