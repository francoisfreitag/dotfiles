local telescope = require("telescope")
telescope.load_extension("fzf")
vim.keymap.set("n", "<c-p>", ":Telescope git_files<cr>")
vim.keymap.set("n", "<c-b>", ":Telescope buffers<cr>")
vim.keymap.set("n", "<Leader>d", ":Telescope diagnostics bufnr=0<cr>")
vim.keymap.set("n", "<Leader>m", ":Telescope oldfiles<cr>")
vim.keymap.set("n", "<c-l>", ":Telescope tags<cr>")
-- Theming https://github.com/craftzdog/solarized-osaka.nvim?tab=readme-ov-file#borderless-telescope-example
require("solarized-osaka").setup({
	on_highlights = function(hl, c)
		local prompt = "#2d3149"
		hl.TelescopeNormal = {
			bg = c.bg_dark,
			fg = c.fg_dark,
		}
		hl.TelescopeBorder = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopePromptNormal = {
			bg = prompt,
		}
		hl.TelescopePromptBorder = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePromptTitle = {
			bg = prompt,
			fg = prompt,
		}
		hl.TelescopePreviewTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
		hl.TelescopeResultsTitle = {
			bg = c.bg_dark,
			fg = c.bg_dark,
		}
	end,
})
