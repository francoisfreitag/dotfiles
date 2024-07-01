require("config")
require("install_lazy")
require("lazy").setup({
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lsp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter")
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform_config")
		end,
	},
	"vim-scripts/matchit.zip",
	"wellle/targets.vim",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns_config")
		end,
	},
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-commentary",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		"tpope/vim-unimpaired",
		config = function()
			vim.keymap.set("n", "[q", ":cprev<cr>zt")
			vim.keymap.set("n", "]q", ":cnext<cr>zt")
		end,
	},
	"dhruvasagar/vim-table-mode",
	"chrisbra/unicode.vim",
	"konfekt/vim-DetectSpellLang",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			extensions = { "fzf", require("lualine_qf") },
			options = {
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
					{
						"diff",
						colored = false,
					},
					{
						"diagnostics",
						colored = false,
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1, -- Relative path
						shorting_target = 20,
					},
				},
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
})
vim.cmd("colorscheme solarized-osaka")

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell suffixesadd=.rst
augroup END
]])
