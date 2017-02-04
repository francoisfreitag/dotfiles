set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular' " Required for vim-markdown
Plugin 'plasticboy/vim-markdown.git'
Plugin 'pangloss/vim-javascript'
Plugin 'neomake/neomake'
Plugin 'vim-scripts/matchit.zip'
Plugin 'digitaltoad/vim-jade'
Plugin 'tmhedberg/SimpylFold'
Plugin 'chase/vim-ansible-yaml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fubitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'sheerun/vim-polyglot'
Plugin 'mhinz/vim-startify'
Plugin 'dhruvasagar/vim-table-mode'
" Themes
Plugin 'nanotech/jellybeans.vim'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'joshdick/onedark.vim'
Plugin 'notpratheek/vim-luna'

" Try list:
" Plugin 'sirver/UltiSnips'

call vundle#end()

filetype indent plugin on
syntax on

set termguicolors
colorscheme onedark

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

" Always display status line
set laststatus=2

" Handy 'save as root'
cmap w!! w !sudo tee % >/dev/null

" Disable mouse
set mouse=

" Custom shortcuts
" ~~~~~~~~~~~~~~~~

" Leader
let mapleader=" "
noremap <Leader><Leader> :noh<CR>
noremap <Leader>g :Gvdiff<CR>
noremap <Leader>o :copen<cr>
noremap <Leader>b Oimport pdb; pdb.set_trace()<ESC>
nnoremap Q <nop>

" Plugins configuration
" ~~~~~~~~~~~~~~~~~~~~~

" Airline
let g:airline#extensions#whitespace#enabled = 0

" Python
let g:SimpylFold_fold_import = 0


" CTRL+P
let g:ctrlp_lazy_update = 1
let g:ctrlp_match_window = 'min:1,max:50,results:50'
" Always search in current directory
nnoremap <c-p> :CtrlPCurWD<cr>
nnoremap <c-l> :CtrlPTag<cr>
nnoremap <c-b> :CtrlPBuffer<cr>
nnoremap <Leader>m :CtrlPMRUFiles<cr>

" Markdown
let g:vim_markdown_folding_disabled = 1

" NerdTree
let g:NERDTreeIgnore=['\.pyc']

map <F2> :NERDTreeToggle<cr>
map <F3> :NERDTreeFind<cr>

" Make ack.vim use the_silver_searcher
let g:ackprg = 'ag --vimgrep'
nnoremap <Leader>a :Ack -w <cword><cr>

" Startify
let g:startify_custom_header = []

let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_open_list = 2  " Open list but preserve current cursor location
let g:neomake_list_height = 3
let g:neomake_xsd_xmllint_maker = {
            \ 'exe': 'xmllint',
            \ 'args': ['--noout'],
            \ }
" This will need a nice error format
let g:neomake_xsd_enabled_makers = ['xmllint']
" let g:neomake_ansible_enabled_makers = ['lint']

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Table mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" Ignore python compiled files
set wildignore+=*.pyc

" Remove all trailing spaces
autocmd BufWritePre * :%s/\v\s+$//e
autocmd BufWritePost * Neomake

" Filetype specific settings
autocmd BufReadPre *.rst,*.md,*.txt setlocal textwidth=79 spell spelllang=en
autocmd BufReadPre *.html,*.js,*.json,*.css setlocal sts=2 sw=2
autocmd BufReadPre *.txt setlocal textwidth=79
autocmd BufReadPre *.yml,*.yaml setlocal nowrap sts=2 sw=2
autocmd BufReadPre COMMIT_EDITMSG setlocal textwidth=72 spell spelllang=en
autocmd BufRead * Neomake
