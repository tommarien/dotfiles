local utils = require('utils')

-- Remove s map (conflicts with mini.surround)
vim.keymap.set({ "n", "x" }, "s", "<Nop>")

-- Exit terminal mode
utils.map('t', '<Esc>', '<C-\\><C-N>', { desc = "Exit Terminal mode", silent = true })

-- Splits
utils.map('n', '<leader>|', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
utils.map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split', silent = true })

-- Better scrolling
utils.map('n', "<C-u>", "<C-u>zz")
utils.map('n', "<C-d>", "<C-d>zz")
utils.map('n', "<C-f>", "<C-f>zz")
utils.map('n', "<C-b>", "<C-b>zz")
utils.map("n", "n", "nzzzv")
utils.map("n", "N", "Nzzzv")

-- Better indent handling
utils.map("v", "<", "<gv")
utils.map("v", ">", ">gv")

-- Move lines up/down
utils.map('v', 'K', ":m '<-2<CR>gv=gv")
utils.map('v', 'J', ":m '>+1<CR>gv=gv")

-- Copy to clipboard
utils.map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy selection to clipboard' })
utils.map('n', '<leader>Y', [["+Y]], { desc = 'Copy lines to clipboard' })
utils.map('n', '<leader>cp', function()
    vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = 'Copy relative file to clipboard' })

-- Visual select last pasted value
utils.map('n', 'gp', '`[v`]', { desc = 'Select last paste' })

-- Black hole register
utils.map('x', '<leader>p', [["_dP]])
