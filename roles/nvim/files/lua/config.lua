vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>a", ":grep! -w <cword><cr>")
vim.keymap.set("n", "<Leader><Leader>", ":nohlsearch<cr>")
vim.keymap.set("c", "grr", "grep!")
vim.keymap.set("n", "gK", function()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "Toggle diagnostic virtual_lines" })

-- Force system python to make startup faster and avoid installing pynvim in
-- each venv.
vim.g.python3_host_prog = "/usr/bin/python3"

vim.opt.formatoptions:append("n")
vim.o.grepprg = "rg --hidden --vimgrep --sort=path"
vim.o.incsearch = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣" }
vim.o.modeline = true
vim.o.mouse = ""
vim.o.number = false
vim.o.scrolloff = 5
vim.o.spelloptions = "camel"
vim.o.undofile = true
vim.opt.winborder = "rounded"
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

vim.diagnostic.config({ virtual_text = true })

vim.filetype.add({
	pattern = {
		[".*/itou/templates/.*%.html"] = { "htmldjango", priority = 10 },
	},
})
