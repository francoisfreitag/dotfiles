vim.g.mapleader = " "
vim.keymap.set("n", "<Leader><Leader>", "<cmd>:noh<cr>")
vim.keymap.set("n", "<Leader>b", "Obreakpoint()<esc>")
vim.keymap.set("n", "<Leader>a", ":grep! -w <cword><cr>")
vim.keymap.set("c", "grr", "grep!")

-- Force system python to make startup faster and avoid installing pynvim in
-- each venv.
vim.g.python3_host_prog = "/usr/bin/python3"

vim.opt.compatible = false

vim.opt.autoindent = true
vim.opt.diffopt = "vertical"
vim.opt.expandtab = true
vim.opt.grepprg = "rg --hidden --vimgrep"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.modeline = true
vim.opt.mouse = ""
vim.opt.number = false
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.textwidth = 0
vim.opt.undofile = true
vim.opt.wrap = true
vim.opt.wrapscan = false

vim.opt.path:append({ "docs", "lua", "*/templates", "templates" })

-- Expand %% to current file's work directory
vim.keymap.set("c", "%%", function()
	if vim.fn.getcmdtype() == ":" then
		return vim.fn.expand("%:h") .. "/"
	else
		return "%%"
	end
end, { expr = true })

-- Detect spell lang
vim.g.detectspelllang_langs = { hunspell = { "fr_FR", "en_US" } }

-- Table mode
vim.g.table_mode_corner_corner = "+"
vim.g.table_mode_header_fillchar = "="

vim.filetype.add({
	pattern = {
		[".*/itou/templates/.*%.html"] = { "htmldjango", priority = 10 },
	},
})
