local utils = require('utils')

utils.map('n', '-', ':Ex<CR>', { desc = 'Browse containing folder', silent = true })
utils.map('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })

utils.map('t', '<Esc>', '<C-\\><C-N>', { desc = "Exit Terminal mode", silent = true })

utils.map('n', '<leader>|', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
utils.map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split', silent = true })
