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
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ansiblels",
					"basedpyright",
					"html",
					"jsonls",
					"lua_ls",
					"ruff",
					"terraformls",
					"ts_ls",
				},
			})
			-- https://github.com/williamboman/nvim-config/tree/mason-v2-example
			vim.lsp.config("*", {
				capabilities = vim.lsp.protocol.make_client_capabilities(),
				root_dir = function(bufnr, on_dir)
					function should_enable(bufname)
						local ignore_patterns = { "fugitive://.*", "^octo://.*" }
						for _, ignore_pattern in pairs(ignore_patterns) do
							if bufname:match(ignore_pattern) then
								return false
							end
						end
						return true
					end
					if should_enable(vim.fn.bufname(bufnr)) then
						on_dir(vim.fn.getcwd())
					end
				end,
			})
		end,
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
			skip_confirm_for_simple_edits = true,
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
			{ "[q", ":cprev<cr>zz", "Previous quickfix item, redrawn at the top" },
			{ "]q", ":cnext<cr>zz", "Next quickfix item, redrawn at the top" },
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

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END
]])
