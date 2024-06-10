require("config")
require("install_lazy")
require("lazy").setup({
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"stevearc/conform.nvim",
	"vim-scripts/matchit.zip",
	"wellle/targets.vim",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",
	"dhruvasagar/vim-table-mode",
	"chrisbra/unicode.vim",
	"konfekt/vim-DetectSpellLang",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
})

vim.cmd("colorscheme solarized-osaka")
require("lsp")
require("treesitter")
require("conform_config")
require("fzf")
require("gitsigns_config")
require("lualine_config")

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell suffixesadd=.rst
augroup END
]])
