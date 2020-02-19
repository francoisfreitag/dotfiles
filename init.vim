set nocompatible

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'prettier/vim-prettier'
Plug 'neomake/neomake'
Plug 'vim-scripts/matchit.zip'
Plug 'mitsuhiko/vim-python-combined'
Plug 'psf/black'
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
set textwidth=79
set wrap
set incsearch
set hlsearch
set nonumber
set history=2000
set hidden
set undofile

" Force system python to:
" - make startup faster
" - avoid installing pynvim in each venv
let g:python3_host_prog = '/usr/bin/python3'

set path+=src,src/legacy,src/*/templates,*/templates,templates,dumps

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
noremap <Leader>b Obreakpoint()<ESC>
noremap <Leader>c :cclose<ESC>
" Expand %% to current file's work directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


" Plugins configuration
" ~~~~~~~~~~~~~~~~~~~~~

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Airline
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='solarized'

" Git gutter
set updatetime=100

" FZF
nnoremap <c-p> :Files<cr>
nnoremap <c-l> :Tags<cr>
nnoremap <c-b> :Buffers<cr>
nnoremap <Leader>m :History<cr>

" JSX Pretty
let g:vim_jsx_pretty_colorful_config = 1

" Markdown
let g:vim_markdown_folding_disabled = 1

" NerdTree
let g:NERDTreeIgnore=['\.pyc']

map <F2> :NERDTreeToggle<cr>
map <F3> :NERDTreeFind<cr>
map <F8> :BTags<cr>

" Make ack.vim use the_silver_searcher
let g:ackprg = 'ag --vimgrep'
" Don't jump to the first result
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack! -w <cword><cr>

" Neomake
call neomake#configure#automake('w', 5000)
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

let g:neomake_python_enabled_makers = ['python', 'flake8', 'isort']

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Table mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" Ignore python compiled files
set wildignore+=*.pyc

" Remove all trailing spaces
autocmd BufWritePre * :%s/\v\s+$//e
let root = trim(system("git rev-parse --show-toplevel 2>/dev/null"))
if !executable("black")
    let g:load_black = 0
else
    let venv = root . "/venv"
    if isdirectory(venv)
        let black = venv . "/bin/black"
        if filereadable(black)
            let g:black_virtualenv = venv
        endif
    endif
    autocmd BufWritePre *.py execute ":Black"
endif

let prettier = root . "/node_modules/.bin/prettier"
if filereadable(prettier)
    let g:prettier#exec_cmd_path = prettier
    autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.json,*.graphql,*.md Prettier
endif

" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead *.html setlocal spell spelllang=en sts=2 sw=2 tw=0
    autocmd BufNewFile,BufRead *.json,*.s?css setlocal sts=4 sw=4 ts=4
    autocmd BufNewFile,BufRead *.php setlocal spell spelllang=en foldmethod=indent foldlevel=20 foldnestmax=21
    autocmd BufNewFile,BufRead *.py setlocal spell spelllang=en foldlevel=3 textwidth=88
    autocmd BufNewFile,BufRead *.md,*.rst,*.txt setlocal spell spelllang=en suffixesadd=.rst
    autocmd BufNewFile,BufRead *.snap setlocal syntax=html sts=2 sw=2 ts=2
    autocmd BufNewFile,BufRead *.txt setlocal syntax=rst
    autocmd BufNewFile,BufRead Jenkinsfile,*.yml,*.yaml setlocal sts=2 sw=2 ts=2
    autocmd BufNewFile,BufRead PKGBUILD setlocal noexpandtab sw=4 ts=4
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=72 spell spelllang=en
augroup END
