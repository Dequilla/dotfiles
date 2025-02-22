-- Helpers
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
    map('n', shortcut, command);
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

-- Press ESC in normal mode to remove highlighted words
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- Simple autocomplete
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
imap("<c-p>", "<c-n>")

-- Numbering
vim.opt.nu = true
vim.opt.numberwidth=4

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

-- Folding
vim.opt.foldmethod=syntax
vim.opt.foldlevel=5
vim.opt.foldclose=all

-- Plugins
vim.cmd([[
    call plug#begin('~/.vim/plugged')
        " Uncomment to check startup timings
        " Plug 'dstein64/vim-startuptime'
    
        " Nerdtree
        Plug 'preservim/nerdtree'
    
        " Highlighting 
        Plug 'sheerun/vim-polyglot'
    
        " Fuzzy search files and buffer
        Plug 'junegunn/fzf', { 'do': { -> fzf--install() } }
        Plug 'junegunn/fzf.vim'
    
        " Nicer tabline
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    
        " Align things for me PLEASE
        Plug 'godlygeek/tabular'
    
        " Fugitive
        Plug 'tpope/vim-fugitive'
    
        " Undotree
        Plug 'mbbill/undotree'
    
        """"""""""
        " Themes "
        """"""""""
        " Plug 'nordtheme/vim'
        " Plug 'morhetz/gruvbox'
        Plug 'alessandroYorba/alduin'
        " Plug 'tomasr/molokai'
    
    call plug#end()
]])

-- Theme
vim.cmd 'colorscheme alduin'
vim.g.airline_theme = 'alduin' 

-- Nerdtree
nmap("<F2>", ":NERDTreeToggle<cr>")
vim.cmd("let NERDTreeShowHidden = 1") -- Show hidden files

-- Undotree
nmap("<F5>", ":UndotreeToggle<CR>")

-- Split
nmap("sv", ":vsplit<cr>")
nmap("sh", ":split<cr>")

-- Fzf
vim.cmd([[
    let g:fzf_vim = {}
    let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
]])

-- Fuzzy search
nmap("<c-f>", ":Ag<Space>")

-- Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")

-- Add shortcut for terminal
if vim.fn.has("win32") then
    -- Backup is powershell
    nmap("<c-t>", ":ter powershell.exe<cr>")
else
    nmap("<c-t>", ":ter<cr>")
end

if vim.fn.has("win32") then
    vim.cmd(":command! BuildRel :!build_and_run.bat build release")
    vim.cmd(":command! BuildDeb :!build_and_run.bat build debug")
    vim.cmd(":command! Run  :!build_and_run.bat run release")
    vim.cmd(":command! Debug :!build_and_run.bat run debug")
else
    vim.cmd(":command! BuildRel :!./build_and_run build release")
    vim.cmd(":command! BuildDeb :!./build_and_run build debug")
    vim.cmd(":command! Run  :!./build_and_run run release")
    vim.cmd(":command! Debug :!./build_and_run run debug")
end

nmap("<c-b><c-d>", ":BuildDeb<cr>")
nmap("<c-b><c-r>", ":BuildRel<cr>")
nmap("<c-r><c-r>", ":Run<cr>")
nmap("<c-r><c-d>", ":Debug<cr>")

-- TODO: Rewrite
-- Generate build_and_run
vim.cmd([[
" Type: basic (barebone), vs (visual studio)
function! GenerateDefaultBuildAndRun(type)
    if filereadable(expand("build_and_run.bat"))
        echo "ERROR: build_and_run.bat already exists."
        return
    endif

    if has("win32")
        echo "Creating build script for windows."

        :let buildCmd = "echo \"Running: %mode% => %target%\""
        if a:type == "vs"
            :let buildCmd = "msbuild.exe -maxCpuCount"
        endif

        let buildScript =<< trim EOF1
            echo off
            set mode=%1
            set target=%2
            IF "%mode%"=="run" (
                IF "%target%"=="debug" (
                    ----build_cmd----
                )
                IF "%target%"=="release" (
                    ----build_cmd----
                )
            )
            IF "%mode%"=="build" (
                IF "%target%"=="debug" (
                    ----build_cmd----
                )
                IF "%target%"=="release" (
                    ----build_cmd----
                ) 
            )
        EOF1


        let buildScript = split(substitute(join(buildScript, "\n"), "----build_cmd----", buildCmd, "g"), "\n")
        :call writefile(buildScript, "build_and_run.bat") 

        :echo buildScript

        " Add build_and_run to gitignore if it exist
        if filereadable(expand(".gitignore"))
            echo "Found .gitignore file, appending build_and_run.bat to it."
            :! @echo.>>".gitignore" 
            :! @echo build_and_run.bat>>.gitignore
        endif
    else
        echo "Creating build script for linux."
        let buildScript =<< trim EOF2
	    #!/bin/bash
            mode=$1
            target=$2
            if [ "$mode" = "run" ]; then
              if [ "$target" = "debug" ]; then
                  echo "$mode => $target"
              elif [ "$target" = "release" ]; then
                  echo "$mode => $target"
              fi
            elif [ "$mode" = "build" ]; then
              if [ "$target" = "debug" ]; then
                  echo "$mode => $target"
              elif [ "$target" = "release" ]; then
                  echo "$mode => $target"
              fi
            fi
        EOF2
        :call writefile(buildScript, "build_and_run") 
        :! chmod +x "build_and_run"

        " Add build_and_run to gitignore if it exist
        if filereadable(expand(".gitignore"))
            :! echo "Found .gitignore file, appending build_and_run to it."
            :! echo -e "build_and_run\n" >> .gitignore
        endif
    endif
endfunction
:command! GenBuildScript :call GenerateDefaultBuildAndRun("basic")
:command! GenBuildScriptVS :call GenerateDefaultBuildAndRun("vs")
]])


-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
  	error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
