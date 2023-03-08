require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim",       lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true, config = true },
	{ import = "plugins" },
	"knubie/vim-kitty-navigator",
	"tpope/vim-repeat",
}, {
	checker = {
		enabled = true, -- automatically check for plugin updates
		notify = false -- don't get a notification when new updates are found. Will be shown in statusline
	}
})
