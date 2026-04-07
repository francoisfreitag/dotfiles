require("config")
vim.pack.add({
	-- fzf-lua, lualine, oil.nvim.
	"https://github.com/nvim-tree/nvim-web-devicons",

	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/tpope/vim-repeat",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/tpope/vim-unimpaired",
	"https://github.com/dhruvasagar/vim-table-mode",
	"https://github.com/konfekt/vim-DetectSpellLang",
})

vim.schedule(function()
	require("nvim-web-devicons").setup()

	require("fzf")
	local fzf_lua = require("fzf-lua")
	fzf_lua.setup({
		winopts = {
			preview = {
				hidden = true,
			},
		},
		fzf_lua.register_ui_select(),
	})

	require("lualine").setup({
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
	})

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
			local function should_enable(bufname)
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

	require("treesitter-context").setup({ max_lines = 8 })

	require("conform_config")

	local oil = require("oil")
	oil.setup({
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
		},
	})
	vim.keymap.set("n", "<F3>", oil.open)
	-- https://github.com/stevearc/oil.nvim/issues/483#issuecomment-3505222158
	vim.g.loaded_netrw = nil

	require("gitsigns_config")

	require("nvim-surround").setup()
end)

vim.keymap.set("n", "[q", ":cprev<cr>zz")
vim.keymap.set("n", "]q", ":cnext<cr>zz")

vim.cmd([[
" Filetype specific settings
augroup vimrc
    autocmd BufNewFile,BufRead neomutt-* setlocal tw=0 spell
    autocmd BufNewFile,BufRead .envrc setlocal filetype=sh
    autocmd BufNewFile,BufRead *.rst setlocal spell suffixesadd=.rst
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufWritePre /tmp/*,.envrc setlocal noundofile
augroup END
]])
