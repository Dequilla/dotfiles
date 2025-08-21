return {
	"nvimdev/dashboard-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			shortcut_type = "number",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						desc = "Open Lazy",
						group = "@property",
						action = "Lazy",
						key = "l",
					},
				},
			},
		})
	end,
}
