local utils = require('utils')

utils.map('n', '-', ':Ex<CR>', { desc = 'Browse containing folder', silent = true })
utils.map('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })

utils.map('t', '<Esc>', '<C-\\><C-N>', { desc = "Exit Terminal mode", silent = true })

utils.map('n', '<leader>|', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
utils.map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split', silent = true })

-- better scrolling
utils.map('n', "<C-u>", "<C-u>zz")
utils.map('n', "<C-d>", "<C-d>zz")
utils.map('n', "<C-f>", "<C-f>zz")
utils.map('n', "<C-b>", "<C-b>zz")
utils.map("n", "n", "nzzzv")
utils.map("n", "N", "Nzzzv")

-- Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
