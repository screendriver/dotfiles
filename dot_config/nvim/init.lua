require("config")

if vim.g.vscode then
	vim.cmd([[
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  ]])
	vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary')
	vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary')
	vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary')
	vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine')
	vim.keymap.set('n', '<Leader>tz', "<Cmd>call VSCodeCall('workbench.action.toggleZenMode')<CR>")
	vim.keymap.set('n', '<Leader>ts', "<Cmd>call VSCodeCall('workbench.action.toggleSidebarVisibility')<CR>")
	vim.keymap.set('x', '<Leader>ts', "<Cmd>call VSCodeCall('workbench.action.toggleSidebarVisibility')<CR>")
	vim.keymap.set('n', '<Leader>rs', "<Cmd>call VSCodeCall('editor.action.rename')<CR>")
	vim.keymap.set('n', '<Leader>qf', "<Cmd>call VSCodeNotify('editor.action.quickFix')<CR>")
end
