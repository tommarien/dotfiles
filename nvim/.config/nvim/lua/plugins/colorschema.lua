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
            transparent = true,
            style = 'darker',
            diagnostics = {
                darker = false,
            },
        },
        init = function()
            vim.cmd('colorscheme onedark')
        end
    },
}
