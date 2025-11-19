return {
	-- 'nordtheme/vim',
	-- "morhetz/gruvbox",
	-- 'tomasr/molokai',
	-- "alessandroYorba/alduin",
	"sainnhe/everforest",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		-- Load the colorscheme here.
		-- Like many other themes, this one has different styles, and you could load
		-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		vim.cmd.colorscheme("everforest")

		-- Set the "hightlight" for bad spelling specifically to ensure it is visible
		vim.cmd("highlight SpellBad ctermbg=188 guibg=#4D1C1C cterm=underline gui=underline")
	end,
}
