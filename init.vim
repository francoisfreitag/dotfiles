set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'klen/python-mode'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular' " Required for vim-markdown
Plugin 'plasticboy/vim-markdown.git'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/syntastic'
Plugin 'digitaltoad/vim-jade'
Plugin 'chase/vim-ansible-yaml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
" Themes
Plugin 'nanotech/jellybeans.vim'

" Try list:
" Plugin 'sirver/UltiSnips'

call vundle#end()

filetype indent plugin on
syntax on

colorscheme jellybeans

" Fix fold colors
highlight Folded ctermbg=Black

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

" FN keys
noremap <F5> :tabp<CR>
noremap <F6> :tabn<CR>

" Plugins configuration
" ~~~~~~~~~~~~~~~~~~~~~

" Airline
let g:airline#extensions#whitespace#enabled = 0

" Python mode
let g:pymode_options = 0
let g:pymode_options_max_line_length = 119
let g:pymode_options_colorcolumn = 1
let g:pymode_rope = 0
let g:pymode_rope_autoimport = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 1
let g:pymode_lint = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'pep257', 'mccabe', 'pylint']
let g:pymode_doc = 0

" CTRL+P
let g:ctrlp_lazy_update = 1
let g:ctrlp_match_window = 'min:1,max:50,results:50'
" Always search in current directory
nnoremap <c-p> :CtrlPCurWD<cr>
" Tags
nnoremap <c-l> :CtrlPTag<cr>
" Buffers
nnoremap <c-b> :CtrlPBuffer<cr>

" NerdTree
let g:NERDTreeIgnore=['\.pyc']

map <F2> :NERDTreeToggle<cr>
map <F3> :NERDTreeFind<cr>

" Make ack.vim use the_silver_searcher
let g:ackprg = 'ag --vimgrep'
nnoremap <Leader>a :Ack <cword><cr>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = "--config node_modules/blease-js/.eslintrc"
let g:syntastic_python_checkers = ['flake8', 'mccabe', 'pylint']

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Ignore python compiled files
set wildignore+=*.pyc

" Remove all trailing spaces
autocmd BufWritePre * :%s/\v\s+$//e

" Filetype specific settings
autocmd bufreadpre *.rst setlocal textwidth=79 spell spelllang=en
autocmd bufreadpre *.js setlocal sts=2 sw=2
autocmd bufreadpre *.txt setlocal textwidth=79
autocmd bufreadpre *.yml,*.yaml setlocal nowrap sts=2 sw=2
autocmd bufreadpre COMMIT_EDITMSG setlocal textwidth=72 spell spelllang=en
