return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
			},
		},
		window = {
			mappings = {
				["s"] = "open_split",
				["v"] = "open_vsplit",
			},
		},
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree file [E]xplorer" },
		{
			"<leader>fe",
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			desc = "Toggle Neotree [E]xplorer [F]ocus",
		},
		{ "<leader>re", "<cmd>NeoTreeReveal<CR>", desc = "[R]eveal file in [E]xplorer" },
	},
}
