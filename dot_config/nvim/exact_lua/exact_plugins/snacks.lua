return {
	"folke/snacks.nvim",
	dependencies = { "stevearc/oil.nvim" },
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {},
		picker = {
			enabled = true,
			formatters = {
				file = {
					truncate = "left",
				},
			},
			layout = {
				layout = {
					width = 0.9,
					height = 0.9,
				},
			},
		},
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
	-- stylua: ignore
	keys = {
		{ "<leader>lg", function() Snacks.lazygit() end, desc = "Open Lazygit", },

		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },

		{ "<leader>fs", function() Snacks.picker.smart({ hidden = true, }) end, desc = "Smart find files", },
		{ "<leader>ff", function() Snacks.picker.files({ hidden = true, }) end, desc = "Find files", },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find buffers", },
		{ "<leader>fg", function() Snacks.picker.grep({ hidden = true, }) end, desc = "Find with grep", },

		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }, },
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Search in registers", },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Search buffer lines", },
		{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search diagnostics", },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Search buffer diagnostics", },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Search in help pages", },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Search in jumps", },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps", },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Search marks", },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Search in undo history", },

		{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition", },
		{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration", },
		{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References", },
		{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation", },
		{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition", },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols", },

		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	},
}
