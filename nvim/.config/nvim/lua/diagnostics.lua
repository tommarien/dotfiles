-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local utils = require('utils');

utils.map('n', '<leader>e', vim.diagnostic.open_float, { silent = true, desc = 'Show diagnostics' })
utils.map('n', '[d', function()
    vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.WARN } })
end, { silent = true, desc = 'Previous diagnostic' })
utils.map('n', ']d', function()
    vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.WARN } })
end, { silent = true, desc = 'Next diagnostic' })
utils.map('n', '<leader>q', vim.diagnostic.setloclist, { silent = true, desc = 'Show diagnostics quickfix' })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        source = 'always',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.HINT] = '󰌶 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
        }
    }
})
