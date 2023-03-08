function _G.check_back_space()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

return {
	"neoclide/coc.nvim",
	branch = "release",
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		vim.cmd [[
				let g:coc_global_extensions = ["coc-css", "coc-eslint", "coc-html", "coc-json", "coc-prettier", "coc-spell-checker", "coc-svelte", "@yaegassy/coc-tailwindcss3", "coc-tsserver", "coc-deno", "coc-fsharp", "coc-lightbulb", "coc-lua", "coc-yaml", "coc-marketplace"]
			]]
		-- Highlight the symbol and its references on a CursorHold event (cursor is idle)
		vim.api.nvim_create_augroup("CocGroup", {})
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "CocGroup",
			command = "silent call CocActionAsync('highlight')",
			desc = "Highlight symbol under cursor on CursorHold"
		})
		-- Update signature help on jump placeholder
		vim.api.nvim_create_autocmd("User", {
			group = "CocGroup",
			pattern = "CocJumpPlaceholder",
			command = "call CocActionAsync('showSignatureHelp')",
			desc = "Update signature help on jump placeholder"
		})
		-- Add ":Format" command to format current buffer
		vim.api.nvim_create_user_command("Format", "call CocAction('format')", { desc = "Format current buffer" })
		-- Add ":OR" command for organize imports of the current buffer
		vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
			{ desc = "Organize imports" })
	end,
	keys = {
		{ "<CR>",       [[coc#pum#visible() ? coc#pum#confirm() : "<CR>"]],                                         mode = "i",    expr = true,                                  desc = "Use <CR> to confirm completion" },
		{ "<C-Space>",  "coc#refresh()",                                                                            mode = "i",    silent = true,                                expr = true,                                                  desc = "Use <C-Space> to trigger completion" },
		{ "<TAB>",      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', mode = "i",    silent = true,                                noremap = true,                                               expr = true,                                 replace_keycodes = false, desc = "Use <S-Tab> to navigate the completion list" },
		{ "<S-TAB>",    [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],                                         mode = "i",    silent = true,                                noremap = true,                                               expr = true,                                 replace_keycodes = false, desc = "Use <S-Tab> to navigate the completion list" },
		-- Use `[g` and `]g` to navigate diagnostics
		-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
		{ "[g",         "<Plug>(coc-diagnostic-prev)",                                                              silent = true },
		{ "]g",         "<Plug>(coc-diagnostic-next)",                                                              silent = true },
		-- GoTo code navigation
		{ "gd",         "<Plug>(coc-definition)",                                                                   silent = true, desc = "[G]o to [D]efinition" },
		{ "gy",         "<Plug>(coc-type-definition)",                                                              silent = true, desc = "[G]o to t[y]pe definition" },
		{ "gi",         "<Plug>(coc-implementation)",                                                               silent = true, desc = "[G]o to [i]mplementation" },
		{ "gr",         "<Plug>(coc-references)",                                                                   silent = true, desc = "[G]o to [R]eferences" },
		{ "K",          "<CMD>lua _G.show_docs()<CR>",                                                              silent = true, desc = "Show documentation in preview window" },
		-- Symbol renaming
		{ "<leader>rn", "<Plug>(coc-rename)",                                                                       silent = true, desc = "[R]e[n]ame symbol" },
		-- Apply code actions at the cursor position.
		{ "<leader>ac", "<Plug>(coc-codeaction-cursor)",                                                            silent = true, nowait = true,                                desc = "[A]pply [C]ode actions at the cursor position" },
		-- Apply the most preferred quickfix action on the current line.
		{ "<leader>qf", "<Plug>(coc-fix-current)",                                                                  silent = true, nowait = true,                                desc = "Apply most preffered [Q]uick[f]ix on the current lin" },
		-- Remap keys for apply refactor code actions.
		{ "<leader>re", "<Plug>(coc-codeaction-refactor)",                                                          silent = true, desc = "[Re]factor code" },
		{ "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)",                                                 mode = "x",    silent = true,                                desc = "[R]efactor code" },
		{ "<leader>r",  "<Plug>(coc-codeaction-refactor-selected)",                                                 silent = true, desc = "[R]efactor code" },
		-- Run the Code Lens actions on the current line
		{ "<leader>cl", "<Plug>(coc-codelens-action)",                                                              silent = true, nowait = true,                                desc = "Run [C]ode [L]ens actions on current line" },
		-- Remap <C-f> and <C-b> to scroll float windows/popups
		{ "<C-f>",      'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',                                   silent = true, nowait = true,                                expr = true },
		{ "<C-b>",      'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',                                   silent = true, nowait = true,                                expr = true },
		{ "<C-f>",      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"',                     mode = "i",    silent = true,                                nowait = true,                                                expr = true },
		{ "<C-b>",      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"',                      mode = "i",    silent = true,                                nowait = true,                                                expr = true },
		{ "<C-f>",      'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"',                                   mode = "v",    silent = true,                                nowait = true,                                                expr = true },
		{ "<C-b>",      'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"',                                   mode = "v",    silent = true,                                nowait = true,                                                expr = true },
	}
}
