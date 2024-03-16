vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("x", "<leader>p", [["_dP]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = true })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
