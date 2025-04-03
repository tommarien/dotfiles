vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'onedark',
    callback = function()
        vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight Comment gui=italic')
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
    },
    {
        'Mofiqul/vscode.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            transparent = true,
            italic_comments = true,
        },
    },
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.melange_enable_font_variants = 0
            vim.cmd('colorscheme melange')
        end
    }
}
