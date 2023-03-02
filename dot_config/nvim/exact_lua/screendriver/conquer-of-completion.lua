vim.cmd [[
let g:coc_global_extensions = ["coc-css", "coc-eslint", "coc-html", "coc-json", "coc-prettier", "coc-spell-checker", "coc-svelte", "@yaegassy/coc-tailwindcss3", "coc-tsserver", "coc-deno", "coc-fsharp", "coc-lightbulb", "coc-lua", "coc-yaml", "coc-marketplace"]
]]

vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "<CR>"]],
	{ expr = true, desc = "Use <CR> to confirm completion" })
vim.keymap.set("i", "<c-space>", "coc#refresh()",
	{ silent = true, expr = true, desc = "Use <C-Space> to trigger completion" })

function _G.check_back_space()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
	{ silent = true, noremap = true, expr = true, replace_keycodes = false,
		desc = "Use <Tab> to navigate the completion list" })
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]],
	{ silent = true, noremap = true, expr = true, replace_keycodes = false,
		desc = "Use <S-Tab> to navigate the completion list" })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
-- GoTo code navigation
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true, desc = "[G]o to [D]efinition" })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true, desc = "[G]o to t[y]pe definition" })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true, desc = "[G]o to [i]mplementation" })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true, desc = "[G]o to [R]eferences" })
-- Use K to show documentation in preview window
function _G.show_docs()
	local cw = vim.fn.expand("<cword>")
	if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
		vim.api.nvim_command("h " .. cw)
	elseif vim.api.nvim_eval("coc#rpc#ready()") then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
	end
end

vim.keymap.set("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true, desc = "Show documentation in preview window" })
-- Highlight the symbol and its references on a CursorHold event (cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
	group = "CocGroup",
	command = "silent call CocActionAsync('highlight')",
	desc = "Highlight symbol under cursor on CursorHold"
})
-- Symbol renaming
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true, desc = "[R]e[n]ame symbol" })
-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
	group = "CocGroup",
	pattern = "CocJumpPlaceholder",
	command = "call CocActionAsync('showSignatureHelp')",
	desc = "Update signature help on jump placeholder"
})
-- Apply code actions at the cursor position.
vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)",
	{ silent = true, nowait = true, desc = "[A]pply [C]ode actions at the cursor position" })
-- Apply the most preferred quickfix action on the current line.
vim.keymap.set("n", "<leader>qf", "<Plug>(coc-fix-current)",
	{ silent = true, nowait = true, desc = "Apply most preffered [Q]uick[f]ix on the current lin" })
-- Remap keys for apply refactor code actions.
vim.keymap.set("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true, desc = "[Re]factor code" })
vim.keymap.set("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true, desc = "[R]efactor code" })
vim.keymap.set("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true, desc = "[R]efactor code" })
-- Run the Code Lens actions on the current line
vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)",
	{ silent = true, nowait = true, desc = "Run [C]ode [L]ens actions on current line" })
-- Remap <C-f> and <C-b> to scroll float windows/popups
local opts = { silent = true, nowait = true, expr = true, desc = "Scroll float windows/popus" }
vim.keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
vim.keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
vim.keymap.set("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
vim.keymap.set("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
vim.keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
vim.keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
-- Add ":Format" command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", { desc = "Format current buffer" })
-- Add ":OR" command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')",
	{ desc = "Organize imports" })
