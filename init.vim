set nocompatible

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'neomake/neomake'
Plug 'vim-scripts/matchit.zip'
Plug 'mitsuhiko/vim-python-combined'
Plug 'tmhedberg/SimpylFold'
Plug 'chase/vim-ansible-yaml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'dhruvasagar/vim-table-mode'
" Themes
Plug 'lifepillar/vim-solarized8'

" Try list:
" Plug 'sirver/UltiSnips'
call plug#end()

" Already performed by Plug
" filetype indent plugin on
" syntax on

set termguicolors
set background=dark
colorscheme solarized8_flat

set ai
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set nojoinspaces

set modeline
set cursorline
set textwidth=79
set wrap
set incsearch
set nohlsearch
set nonumber
set history=2000
set hidden
set undofile

" Force system python to:
" - make startup faster
" - avoid installing pynvim in each venv
let g:python3_host_prog = '/usr/bin/python3'

set path+=src,src/legacy

" Always display status line
set laststatus=2

" Handy 'save as root'
cmap w!! w !sudo tee % >/dev/null

set mouse=

set diffopt=vertical

" Custom shortcuts
" ~~~~~~~~~~~~~~~~

" Leader
let mapleader=" "
noremap <Leader><Leader> :noh<CR>
noremap <Leader>g :Gvdiff<CR>
noremap <Leader>o :copen<cr>
noremap <Leader>b Oimport pdb; pdb.set_trace()<ESC>
noremap <Leader>c :cclose<ESC>
" Expand %% to current file's work directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" Plugins configuration
" ~~~~~~~~~~~~~~~~~~~~~

" Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='solarized'

" Python
let g:SimpylFold_fold_import = 0


" FZF
nnoremap <c-p> :Files<cr>
nnoremap <c-l> :Tags<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <Leader>m :History<cr>

" Markdown
let g:vim_markdown_folding_disabled = 1

" NerdTree
let g:NERDTreeIgnore=['\.pyc']

map <F2> :NERDTreeToggle<cr>
map <F3> :NERDTreeFind<cr>

" Make ack.vim use the_silver_searcher
let g:ackprg = 'ag --vimgrep'
" Don't jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack! -w <cword><cr>

" Simpylfold
let g:SimpylFold_docstring_preview = 1

" Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_maker_args = ['--config', '--format', '--compact', '--ext', '.js,.jsx']

let g:neomake_open_list = 2  " Open list but preserve current cursor location
let g:neomake_list_height = 3
let g:neomake_xsd_xmllint_maker = {
            \ 'exe': 'xmllint',
            \ 'args': ['--noout'],
            \ }
" This will need a nice error format
let g:neomake_xsd_enabled_makers = ['xmllint']
let g:neomake_python_isort_maker = {
    \ 'exe': 'isort',
    \ 'args': ['-c'],
    \ 'errorformat': '%tRROR: %f %m',
    \ }

let g:neomake_python_enabled_makers = ['python', 'pyflakes', 'pylint', 'isort']

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Table mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" Ignore python compiled files
set wildignore+=*.pyc

" Remove all trailing spaces
autocmd BufWritePre * :%s/\v\s+$//e
autocmd BufWritePost *.py :silent !isort "%"
autocmd BufWritePost * Neomake

" Filetype specific settings
autocmd BufReadPre *.md,*.rst,*.txt setlocal textwidth=79 spell spelllang=en suffixesadd=.rst
autocmd BufRead *.txt setlocal syntax=rst
autocmd BufReadPre *.html setlocal spell spelllang=en sts=2 sw=2 tw=0
autocmd BufReadPre *.js,*.json,*.s?css setlocal sts=4 sw=4
autocmd BufReadPre *.yml,*.yaml setlocal sts=2 sw=2
autocmd BufReadPre *.php setlocal foldmethod=indent foldlevel=20 foldnestmax=21
autocmd BufReadPre COMMIT_EDITMSG setlocal textwidth=72 spell spelllang=en
autocmd BufRead * Neomake
