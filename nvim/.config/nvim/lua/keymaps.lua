-- Functional wrapper for mapping custom keybindings
local function map(mode, key, cmd, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, key, cmd, options)
end

map('n', '-', ':Ex<CR>', { desc = 'Browse containing folder', silent = true })
map('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })

map('t', '<Esc>', '<C-\\><C-N>', { desc = "Exit Terminal mode", silent = true })

map('n', '<leader>|', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split', silent = true })
