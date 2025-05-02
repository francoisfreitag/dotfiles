require("config")
require("install_lazy")
require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 8,
		},
	},
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason-lspconfig.nvim",
		opts = { automatic_installation = true },
	},
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
			skip_confirm_for_simple_edits = false,
			view_options = {
				show_hidden = true,
			},
		},
		lazy = false,
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
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	{
		"tpope/vim-unimpaired",
		keys = {
			{ "[q", ":cprev<cr>zt", "Previous quickfix item, redrawn at the top" },
			{ "]q", ":cnext<cr>zt", "Next quickfix item, redrawn at the top" },
		},
		lazy = false,
	},
	"dhruvasagar/vim-table-mode",
	{
		"allaman/emoji.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
		},
		keys = {
			{ "<leader>pe", ":Emoji<cr>", { desc = "[P]ick [E]moji" } },
		},
		config = function(_, opts)
			require("emoji").setup(opts)
			require("fzf-lua").register_ui_select()
		end,
	},
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
			transparent_background = true,
			styles = {
				comments = {},
				conditionals = {},
			},
		},
	},
})
vim.o.termguicolors = true
vim.cmd.colorscheme("catppuccin")

vim.lsp.enable({
	"ansiblels",
	"basedpyright",
	"htmlls",
	"jsonls",
	"luals",
	"ruff",
	"terraformls",
	"typescriptls",
})

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END
]])
