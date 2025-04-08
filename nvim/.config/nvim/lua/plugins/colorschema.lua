vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight Comment gui=italic')
        vim.cmd('highlight CursorLine guibg=none')
    end,
})

return {
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.melange_enable_font_variants = 0
            vim.cmd('colorscheme melange')
        end
    },
}
