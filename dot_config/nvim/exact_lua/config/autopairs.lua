local npairs = require("nvim-autopairs")
npairs.setup({
	map_cr = false
})

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.completion_confirm = function()
	if vim.fn["coc#pum#visible"]() ~= 0 then
		return vim.fn["coc#pum#confirm"]()
	else
		return npairs.autopairs_cr()
	end
end

vim.keymap.set("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })
