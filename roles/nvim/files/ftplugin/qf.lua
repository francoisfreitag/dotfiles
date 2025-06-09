vim.cmd([[packadd cfilter]])
vim.keymap.set("n", "gq", ":cclose<CR>")
vim.keymap.set("n", "]f", ":cnfile<CR>")
vim.keymap.set("n", "[f", ":cpfile<CR>")
