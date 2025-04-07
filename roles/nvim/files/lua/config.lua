vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>a", ":grep! -w <cword><cr>")
vim.keymap.set("c", "grr", "grep!")
vim.keymap.set("n", "gK", function()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "Toggle diagnostic virtual_lines" })

-- Force system python to make startup faster and avoid installing pynvim in
-- each venv.
vim.g.python3_host_prog = "/usr/bin/python3"

vim.o.compatible = false

vim.o.autoindent = true
vim.o.diffopt = "internal,filler,closeoff,vertical,linematch:60"
vim.o.expandtab = true
vim.opt.formatoptions:append("n")
vim.o.grepprg = "rg --hidden --vimgrep"
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣" }
vim.o.joinspaces = false
vim.o.modeline = true
vim.o.mouse = ""
vim.o.number = false
vim.o.scrolloff = 5
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.spelloptions = "camel"
vim.o.tabstop = 4
vim.o.textwidth = 0
vim.o.undofile = true
vim.o.wrap = true

vim.opt.path:append({ "docs", "lua", "*/templates", "templates", "*/static" })

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
