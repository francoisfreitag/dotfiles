vim.cmd([[packadd cfilter]])
vim.keymap.set("n", "gq", ":cclose<CR>", { buffer = true })
vim.keymap.set("n", "]f", ":cnfile<CR>", { buffer = true })
vim.keymap.set("n", "[f", ":cpfile<CR>", { buffer = true })
