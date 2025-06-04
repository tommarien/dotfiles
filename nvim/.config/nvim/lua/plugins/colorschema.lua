vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight CursorLine guibg=none')
        vim.cmd('highlight Normal guibg=none')
        vim.cmd('highlight SnacksIndent guifg=#3a3734')
        vim.cmd('highlight SnacksIndentScope guifg=#8a7d73')
        vim.cmd('highlight String gui=none')
    end,
})

return {
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false,
        init = function()
            vim.cmd('colorscheme melange')
        end
    },
}
