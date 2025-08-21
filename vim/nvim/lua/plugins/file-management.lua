return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/snacks.nvim",
	},
	config = function()
		nmap("<F2>", ":Neotree toggle<cr>")
		nmap("<F3>", ":Neotree toggle git_status float<cr>")
	end,
}
