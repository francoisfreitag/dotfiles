set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'klen/python-mode'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'plasticboy/vim-markdown.git'
" HTML
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'pangloss/vim-javascript'
Plugin 'chase/vim-ansible-yaml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
" Themes
Plugin 'sickill/vim-monokai'

" Try list:
" Plugin 'sirver/UltiSnips'

call vundle#end()

filetype indent plugin on
syntax on

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

" Airline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Python mode
let g:pymode_options = 0
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
let g:pymode_doc = 0

" CTRL+P
" Always search in current directory
map <c-p> :CtrlPCurWD<CR>
" Map search tags to CTRL+M
map <c-m> :CtrlPTag<CR>

" NerdTree
map <F2> :NERDTreeToggle<CR>

" Remove all trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Filetype specific settings
autocmd bufreadpre *.rst setlocal textwidth=79
autocmd bufreadpre COMMIT_EDITMSG setlocal textwidth=72
