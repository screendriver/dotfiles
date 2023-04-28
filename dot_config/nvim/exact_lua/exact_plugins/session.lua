return {
	"rmagatti/auto-session",
	lazy = false,
	init = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
	config = true,
}
