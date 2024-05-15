-- Leader
vim.g.mapleader = " "
vim.keymap.set('n', '<Leader><Leader>', '<cmd>:noh<cr>')
vim.keymap.set('n', '<Leader>g', ':Gvdiff<cr>')
vim.keymap.set('n', '<Leader>o', ':copen<cr>')
vim.keymap.set('n', '<Leader>c', ':cclose<esc>')
vim.keymap.set('n', '<Leader>b', 'Obreakpoint()<esc>')

-- Force system python to make startup faster and avoid installing pynvim in
-- each venv.
vim.g.python3_host_prog = '/usr/bin/python3'

vim.opt.compatible = false

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.ai = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.joinspaces = false

vim.opt.modeline = true
vim.opt.scrolloff = 5
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.number = false
vim.opt.hidden = true
vim.opt.undofile = true
vim.opt.diffopt = "vertical"
vim.opt.mouse = ""

vim.opt.path:append({"docs", "*/templates", "templates"})
-- Ignore python compiled files
vim.opt.wildignore:append("*.pyc")

-- Always display status line
vim.opt.laststatus = 2

-- Expand %% to current file's work directory
vim.keymap.set(
    'c',
    '%%',
    function()
        if vim.fn.getcmdtype() == ':' then
            return vim.fn.expand('%:h') .. '/'
        else
            return '%%'
        end
    end,
    { expr = true }
)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Ack.vim
vim.g.ackprg = 'rg --hidden --vimgrep --no-heading'
vim.keymap.set('n', '<Leader>a', ':Ack! -w <cword><cr>')
-- Don't jump to the first result
vim.keymap.set('c', 'ack', 'Ack!')
vim.keymap.set('c', 'Ack', 'Ack!')
-- Airline
vim.g['airline#extensions#ale#enabled'] = 1
vim.g['airline#extensions#whitespace#enabled'] = 0
vim.g.airline_theme='solarized'
-- ALE
vim.g.ale_open_list = 'on_save'
vim.g.ale_list_window_size = 3
vim.g.ale_fix_on_save = 1
vim.g.ale_warn_about_trailing_blank_lines = 0
vim.g.ale_warn_about_trailing_whitespace = 0
vim.keymap.set('n', '<c-k>', '<Plug>(ale_previous_wrap)', {silent = true})
vim.keymap.set('n', '<c-j>', '<Plug>(ale_next_wrap)', {silent = true})
vim.cmd([[
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
]])
-- DetectSpellLang
vim.g.detectspelllang_langs = { hunspell = { 'fr_FR', 'en_US' }}
-- EditorConfig
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}
-- FZF
vim.keymap.set('n', '<c-p>', ':Files<cr>')
vim.keymap.set('n', '<c-l>', ':Tags<cr>')
vim.keymap.set('n', '<c-b>', ':Buffers<cr>')
vim.keymap.set('n', '<Leader>m', ':History<cr>')
-- Git gutter
vim.opt.updatetime = 100
-- NerdTree
vim.g.NERDTreeIgnore = {'.pyc'}
vim.keymap.set('n', '<F2>', ':NERDTreeToggle<cr>')
vim.keymap.set('n', '<F3>', ':NERDTreeFind<cr>')
-- Table mode
vim.g.table_mode_corner_corner = "+"
vim.g.table_mode_header_fillchar = "="


require("lazy").setup({
    "konfekt/vim-DetectSpellLang",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "mileszs/ack.vim",
    "dense-analysis/ale",
    "stevearc/conform.nvim",
    "vim-scripts/matchit.zip",
    "wellle/targets.vim",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-commentary",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    "tpope/vim-unimpaired",
    "airblade/vim-gitgutter",
    "scrooloose/nerdtree",
    "dhruvasagar/vim-table-mode",
    "chrisbra/unicode.vim",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- Themes
    "lifepillar/vim-solarized8",
})
vim.cmd("colorscheme solarized8_flat")

---------
-- LSP --
---------
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  if client.name == 'ruff_lsp' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'html', 'jsonls', 'pylsp', 'pyright', 'ruff_lsp', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

--------------
-- Tree-sitter
--------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "css", "javascript", "html", "htmldjango", "python", "vim", "vimdoc"},
  auto_install = true,

  highlight = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>s"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>S"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
      goto_next = {
        ["]d"] = "@conditional.outer",
      },
      goto_previous = {
        ["[d"] = "@conditional.outer",
      }
    },
  },
}

-- Conform.nvim
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    htmldjango = { "djlint" },
    lua = { "stylua" },
    python = function(bufnr)
      if conform.get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_fix", "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    ["*"] = { "trim_newlines", "trim_whitespace" }
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.md,*.rst,*.txt setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.txt setlocal filetype=md
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal textwidth=72 spell
    autocmd BufNewFile,BufRead PULLREQ_EDITMSG setlocal tw=0 spell
augroup END
]])
