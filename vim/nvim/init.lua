-- Helpers
require("config.helpers")

-- Basic configuration
require("config.basic")

-- Building and running
require("config.build_and_run")

-- Simple autocomplete
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
imap("<c-p>", "<c-n>")

vim.opt.foldlevel = 5
vim.opt.foldclose = "all"

-- Same autocommand written with a Lua function instead
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.cpp", "*.h", "*cxx", "*.c", "*.rs", "*.py", "*.sh", "*.glsl", "*.html", "*.css", "*.js" },
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

-- Undotree
nmap("<F5>", ":UndotreeToggle<CR>")

-- Fzf
vim.cmd([[
    let g:fzf_vim = {}
    let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
]])

-- Fuzzy search
nmap("<c-f>", ":Ag<Space>")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})
