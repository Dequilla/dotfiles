-- Press ESC in normal mode to remove highlighted words
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Leader like wtf what keyboard is \ easy to use on
vim.g.mapleader = ","

-- Add pairs for %
vim.opt.mps:append("<:>")

-- Detect filetypes
vim.cmd(":filetype on")
vim.cmd(":filetype plugin on")
vim.cmd(":filetype indent on")

-- Syntax highlighting
vim.cmd(":syntax on")

-- Hightlight cursor line
vim.opt.cursorline = true

-- Tabs and shifting
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Better scrolling
vim.opt.scrolloff = 10
-- Show tabs
vim.opt.list = true
vim.opt.listchars = "tab:>-"

-- Better search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.hlsearch = true

-- Mode show
vim.opt.showmode = true

-- Longer history
vim.opt.history = 100

-- Numbering
vim.opt.nu = true
vim.opt.numberwidth = 4

-- Status line format
vim.cmd([[
	set statusline=""
	set statusline+="\ %F\ %M\ %Y\ %R"
	set statusline+="%="
	set statusline+="\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%"
	set laststatus=2
]])

-- Encoding
vim.opt.encoding = "utf-8"

-- Theme
vim.g.airline_theme = "alduin"

-- Nerdtree
nmap("<F2>", ":NERDTreeToggle<cr>")
vim.cmd("let NERDTreeShowHidden = 1") -- Show hidden files

-- Split
nmap("sv", ":vsplit<cr>")
nmap("sh", ":split<cr>")

-- Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")

-- Resize splits
nmap("<a-h>", "2<c-w><")
nmap("<a-l>", "2<c-w>>")
nmap("<a-j>", "2<c-w>+")
nmap("<a-k>", "2<c-w>-")

-- Add shortcut for terminal
nmap("<c-t>", ":ter<cr>")
if vim.fn.has("win32") then
	vim.opt.shell = "powershell"
	vim.opt.shellcmdflag = "-command"
	vim.opt.shellquote = '"'
	vim.opt.shellxquote = ""
end
