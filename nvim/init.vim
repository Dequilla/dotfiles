"""""""""""""""""
" NeoVim config "
"""""""""""""""""

" Disable vi compability
set nocompatible

" Detect filetypes
filetype on
filetype plugin on
filetype indent on

" Syntax highlighting
syntax on

" Hightlight cursor line
set cursorline

" Tabs and shifting
set shiftwidth=4
set tabstop=4
set expandtab

" Better scrolling
set scrolloff=10

" Show tabs
set list
set listchars=tab:>-

" Better search
set incsearch
set ignorecase
set smartcase 
set showmatch
set hlsearch

" Mode show
set showmode

" Longer history
set history=100

" Simple autocomplete
set wildmenu
set wildmode=list:longest
imap <c-p> <c-n>

" Numbering
set nu
set numberwidth=4

" Status line format
set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

" Encoding
set encoding=utf-8

" Folding
set foldmethod=syntax
set foldlevel=5
set foldclose=all

" lugins
call plug#begin('~/.vim/plugged')
    " Uncomment to check startup timings
    " Plug 'dstein64/vim-startuptime'

    " Nerdtree
    Plug 'preservim/nerdtree'

    " Highlighting 
    Plug 'sheerun/vim-polyglot'

    " Fuzzy search files and buffer
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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

" Colorscheme
:colorscheme alduin

" Set theme of Airline statusline
let g:airline_theme='alduin'

" Map nerdtree to key
nnoremap <F2> :NERDTreeToggle<cr> 

" Map undotree
nnoremap <F5> :UndotreeToggle<CR>

" Splitlet g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
nnoremap sv :vsplit<cr>
nnoremap sh :split<cr>

"""""""""""""""""""""""""""""
" fzf
" Initialize configuration dictionary
let g:fzf_vim = {}

let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

" ctrl + f to do fuzzy search in project
" Find in file or file name
nmap <c-f> :Ag<Space>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion (TODO: Fix for both platforms (win and linux)
imap <c-x><c-p> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"""""""""""""""""""""""""""""

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Add shortcut for terminal
if has("win32")
    " Backup is powershell
    nnoremap <c-t> :ter powershell.exe<cr>
else
    nnoremap <c-t> :ter<cr>
endif

if has("win32")
    :command! BuildRel :!build_and_run.bat build release
    :command! BuildDeb :!build_and_run.bat build debug
    :command! Run  :!build_and_run.bat run release
    :command! Debug :!build_and_run.bat run debug
else
    :command! BuildRel :!./build_and_run build release
    :command! BuildDeb :!./build_and_run build debug
    :command! Run  :!./build_and_run run release
    :command! Debug :!./build_and_run run debug
endif

nnoremap <c-b><c-d> :BuildDeb<cr>
nnoremap <c-b><c-r> :BuildRel<cr>
nnoremap <c-r><c-r> :Run<cr>
nnoremap <c-r><c-d> :Debug<cr>

" On window to build VisualStudio project
if has("win32")
    :command! -nargs=1 BuildVS :!"C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe" <args>.sln /Build "Debug|x64"
endif

" Open a specific NOTE file that is always in the same locations
function! OpenPersonalNote()
    :vsplit ~/notes.md
endfunction

:command! Note :call OpenPersonalNote()

" Type: basic (barebone), vs (visual studio)
function! GenerateDefaultBuildAndRun(type)
    if filereadable(expand("build_and_run.bat"))
        echo "ERROR: build_and_run.bat already exists."
        return
    endif

    if has("win32")
        echo "Creating build script for windows."
        let buildScript =<< trim EOF1
            echo off
            set mode=%1
            set target=%2
            IF "%mode%"=="run" (
                IF "%target%"=="debug" (
                    echo "Running: %mode% => %target%"
                )
                IF "%target%"=="release" (
                    echo "Running: %mode% => %target%"
                )
            )
            IF "%mode%"=="build" (
                IF "%target%"=="debug" (
                    echo "Building: %mode% => %target%"
                )
                IF "%target%"=="release" (
                    echo "Building: %mode% => %target%"
                ) 
            )
        EOF1
        :call writefile(buildScript, "build_and_run.bat") 

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
