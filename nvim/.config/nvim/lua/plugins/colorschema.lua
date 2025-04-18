vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight String gui=none')
        vim.cmd('highlight CursorLine guibg=none')
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
