-- Helpers
require("config.helpers")

-- Basic configuration
require("config.basic")

-- Building and running
require("config.build_and_run")

-- Cheat sheet with info I use more often
require("config.cheatsheet")

-- MSBuild
require("config.MSBuild")

-- Add personal help-documents
vim.api.nvim_create_augroup("MyHelpTags", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "MyHelpTags",
	-- Pattern to match any file in your config's doc/ directory
	pattern = vim.fn.stdpath("config") .. "/doc/*.txt",
	-- Command to run
	command = "helptags " .. vim.fn.stdpath("config") .. "/doc",
})

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
