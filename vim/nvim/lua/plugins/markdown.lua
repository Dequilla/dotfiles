return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = {
			"markdown",
		},
		opts = {
			enabled = true, -- Just in case
			render_modes = { "n", "c", "t" }, -- Remove rendering while insert mode
			code = {
				-- Stop showing a white bar at the top of code blocks.
				language_border = " ",
			},
			completions = {
				lsp = {
					enabled = true,
				},
			},
		},
	},
}
