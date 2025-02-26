vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'onedark',
    callback = function()
        vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
    end,
})

return {
    {
        'navarasu/onedark.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'darker',
            diagnostics = {
                darker = false,
            },
        },
        config = function(_, opts)
            require('onedark').setup(opts)
            vim.cmd('colorscheme onedark')
        end,
    },
}
