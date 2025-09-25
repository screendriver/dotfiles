return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local cspellNamespace = lint.get_namespace("cspell")

		lint.linters_by_ft = {
			markdown = { "markdownlint" },
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
				lint.try_lint(nil, { ignore_errors = true })
				if ev.event ~= "BufEnter" then
					lint.try_lint("cspell")
				end
			end,
		})
	end,
}
