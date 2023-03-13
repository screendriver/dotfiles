return {
	{
		"ionide/Ionide-vim",
		init = function()
			vim.g["fsharp#backend"] = "nvim"
			vim.g["fsharp#fsautocomplete_command"] = vim.api.nvim_eval('["fsautocomplete"]')
		end,
	}
}
