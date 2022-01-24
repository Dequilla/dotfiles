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

" Plugins
call plug#begin('~/.vim/plugged')

    " Nerdtree
    Plug 'preservim/nerdtree'

    " Highlighting 
    Plug 'sheerun/vim-polyglot'

    " Fuzzy search files and buffer
    Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" Map nerdtree to key
nnoremap <F2> :NERDTreeToggle<cr> 

" Split
nnoremap sv :vsplit<cr>
nnoremap sh :split<cr>

" CtrlP Fuzzy search
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Add shortcut for terminal
nnoremap <c-t> :ter<cr>

" Colorscheme
:colorscheme molokai
