set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/vundle'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'klen/python-mode'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'plasticboy/vim-markdown.git'
" HTML
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'sickill/vim-monokai'
Bundle 'Valloric/YouCompleteMe'

" Try list:
" Bundle 'sirver/UltiSnips'
" Bundle 'scrooloose/nerdtree'

call vundle#end()

filetype indent plugin on
syntax on

let mapleader=" "
noremap <Leader><Leader> :noh<CR>
noremap <Leader>g :Gvdiff<CR>

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
let g:Powerline_symbols = 'fancy'
set guifont=Inconsolata\ for\ Powerline\ 9
set laststatus=2

" Python mode
let g:pymode_options = 1
let g:pymode_options_max_line_length = 119
let g:pymode_options_colorcolumn = 1
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 1
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = "E128"

" CTRL+P
" Always search in current directory
map <c-p> :CtrlPCurWD<CR>
" Map search tags to CTRL+M
map <c-m> :CtrlPTag<CR>

" Remove all trailing spaces
autocmd BufWritePre * :%s/\s\+$//e
