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
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<F3>", "<cmd>:e %:h<cr>", desc = "Open oil.nvim in current dir" },
		},
		opts = {
			view_options = {
				show_hidden = true,
			},
		},
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform_config")
		end,
	},
	"vim-scripts/matchit.zip",
	"romainl/vim-cool",
	"wellle/targets.vim",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns_config")
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			vim.keymap.set("n", "<Leader>n", ":Neogit<cr>")
			require("neogit").setup({
				sections = {
					untracked = { folded = true },
				},
			})
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
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			styles = {
				comments = {},
				conditionals = {},
			},
		},
	},
})
vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin")

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END
]])
