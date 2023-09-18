-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local utils = require('utils');

utils.map('n', '<leader>e', vim.diagnostic.open_float, { silent = true, desc = 'Show diagnostics' })
utils.map('n', '[d', vim.diagnostic.goto_prev, { silent = true, desc = 'Previous diagnostic' })
utils.map('n', ']d', vim.diagnostic.goto_next, { silent = true, desc = 'Next diagnostic' })
utils.map('n', '<leader>q', vim.diagnostic.setloclist, { silent = true, desc = 'Show diagnostics quickfix' })

-- Make definition and signature_help bordered
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
})


utils.sign({ name = 'DiagnosticSignError', text = '󰅚 ' })
utils.sign({ name = 'DiagnosticSignWarn', text = '󰀪 ' })
utils.sign({ name = 'DiagnosticSignHint', text = '󰌶 ' })
utils.sign({ name = 'DiagnosticSignInfo', text = '󰋽 ' })

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})
