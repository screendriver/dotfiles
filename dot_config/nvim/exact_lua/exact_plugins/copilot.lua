return {
	"zbirenbaum/copilot.lua",
	dependencies = { "fang2hou/blink-copilot" },
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		panel = {
			enabled = true,
			auto_refresh = true,
		},
		suggestion = {
			enabled = false,
		},
	},
	keys = {
		{
			"<leader>cp",
			mode = { "n" },
			function()
				require("copilot.panel").toggle()
			end,
			desc = "Copilot panel",
		},
	},
}
