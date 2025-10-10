return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"folke/snacks.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					show_hidden_count = true,
				},
			},
		})

		nmap("<F2>", ":Neotree toggle left<cr>")
		nmap("<F3>", ":Neotree toggle git_status left<cr>")
	end,
}
