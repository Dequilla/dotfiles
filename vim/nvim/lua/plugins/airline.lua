return {
	-- Nicer tabline
	"vim-airline/vim-airline",
	dependencies = {
		"vim-airline/vim-airline-themes",
	},
	config = function()
		vim.g.airline_theme = "alduin"
	end,
}
