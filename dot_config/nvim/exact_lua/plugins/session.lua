return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end
}
