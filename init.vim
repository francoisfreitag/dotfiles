set nocompatible

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'vim-scripts/matchit.zip'
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
Plug 'sheerun/vim-polyglot'
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
set textwidth=80
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
" Disable Python 2 support
let g:loaded_python_provider = 0

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
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='solarized'

" ALE
let g:ale_open_list = 'on_save'
let g:ale_list_window_size = 3
let g:ale_fix_on_save = 1
let fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'php': ['remove_trailing_lines', 'trim_whitespace', 'php_cs_fixer'],
\}
let root = trim(system("git rev-parse --show-toplevel 2>/dev/null")) . "/"

let venv = root . "venv/"
let py_fixers = ['remove_trailing_lines', 'trim_whitespace', 'isort']
if isdirectory(venv) && filereadable(venv . "bin/black")
    call add(py_fixers, 'black')
endif
let fixers['python'] = py_fixers

let js_fixers = ['remove_trailing_lines', 'trim_whitespace']
let js_root = root . "node_modules/"
for js_linter in ['eslint', 'prettier']
    if executable(js_root . ".bin/" . js_linter)
        call add(js_fixers, js_linter)
    endif
endfor
let fixers['javascript'] = js_fixers

let g:ale_fixers = fixers

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
augroup CloseLoclistWindowGroup
autocmd!
autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

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

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Table mode
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" Ignore python compiled files
set wildignore+=*.pyc

" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead EDIT_PR_MSG_* set filetype=gitcommit
    autocmd BufNewFile,BufRead *.html setlocal spell spelllang=en sts=2 sw=2 tw=0
    autocmd BufNewFile,BufRead *.s?css setlocal sts=4 sw=4 ts=4
    autocmd BufNewFile,BufRead *.php setlocal spell spelllang=en foldmethod=indent foldlevel=20 foldnestmax=21
    autocmd BufNewFile,BufRead *.py setlocal spell spelllang=en foldlevel=3 textwidth=88
    autocmd BufNewFile,BufRead *.md,*.rst,*.txt setlocal spell spelllang=en suffixesadd=.rst
    autocmd BufNewFile,BufRead *.snap setlocal syntax=html sts=2 sw=2 ts=2
    autocmd BufNewFile,BufRead *.txt setlocal syntax=rst
    autocmd BufNewFile,BufRead Jenkinsfile,*.yml,*.yaml setlocal sts=2 sw=2 ts=2
    autocmd BufNewFile,BufRead PKGBUILD setlocal noexpandtab sw=4 ts=4
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=72 spell spelllang=en
augroup END
