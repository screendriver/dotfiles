return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup()
		require("mini.diff").setup()

		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },

				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		require("mini.pairs").setup()
	end,
}
