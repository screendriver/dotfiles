local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"

	use "Mofiqul/dracula.nvim"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	}
	use "nvim-tree/nvim-web-devicons"
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true }
	}
	use "unblevable/quick-scope"
	use "nvim-lua/plenary.nvim"
	use "nvim-lua/popup.nvim"
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
	use {
		"nvim-telescope/telescope.nvim", branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } }
	}
	use {
		"AckslD/nvim-neoclip.lua",
		requires = { { "nvim-telescope/telescope.nvim" } },
	}
	use {
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		}
	}
	use {
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" }
	}
	use { "neoclide/coc.nvim", branch = "release" }
	use "chentoast/marks.nvim"
	use "terrortylor/nvim-comment"
	use "folke/zen-mode.nvim"
	use "kdheepak/lazygit.nvim"
	use "lewis6991/gitsigns.nvim"
	use "luukvbaal/nnn.nvim"
	use "windwp/nvim-autopairs"
	use "NvChad/nvim-colorizer.lua"

	if packer_bootstrap then
		require("packer").sync()
	end
end)
