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

" Plugins
call plug#begin('~/.vim/plugged')

    " Nerdtree
    Plug 'preservim/nerdtree'

    " Highlighting 
    Plug 'sheerun/vim-polyglot'

    " Fuzzy search files and buffer
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

call plug#end()

" Map nerdtree to key
nnoremap <F2> :NERDTreeToggle<cr> 

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
nnoremap <c-t> :ter<cr>

" Colorscheme
:colorscheme molokai

:command Build :!./build.sh
:command Run  :!./run.sh
nnoremap <c-b> :Build<cr>
nnoremap <c-r> :Run<cr>

" On window to build VisualStudio project
if has("win32")
    :command -nargs=1 BuildVS :!"C:/Program Files/Microsoft Visual Studio/2022/Professional/Common7/IDE/devenv.exe" <args>.sln /Build "Debug|x64"
endif
