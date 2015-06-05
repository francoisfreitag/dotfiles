set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'klen/python-mode'
Bundle 'kien/ctrlp.vim'
Bundle 'plasticboy/vim-markdown.git'
" HTML
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'pangloss/vim-javascript'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'sickill/vim-monokai'
Bundle 'Valloric/YouCompleteMe'

syntax on
filetype indent plugin on

colors monokai

set ai
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

set modeline
set textwidth=119
set wrap
set hlsearch
set nonumber

" Powerline configuration
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" Python mode
let g:pymode_options_max_line_length = 119
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 1
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = "E128"

" CTRL+P
" Map search tags to CTRL+M
map <c-m> :CtrlPTag<CR>

" Remove all trailing spaces
autocmd BufWritePre * :%s/\s\+$//e
