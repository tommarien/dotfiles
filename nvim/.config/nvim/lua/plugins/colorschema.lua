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
            vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
        end,
    },
}
