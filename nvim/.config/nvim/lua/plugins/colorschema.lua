vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight Comment guifg=#9d8b78')
        vim.cmd('highlight CursorLine guibg=none')
        vim.cmd('highlight GitSignsCurrentLineBlame guifg=#7d6b58')
        vim.cmd('highlight LspReferenceText guibg=#383128 gui=none')
        vim.cmd('highlight MatchParen guibg=#413a30')
        vim.cmd('highlight NormalFloat guibg=none')
        vim.cmd('highlight String gui=none')
    end,
})

return {
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd('colorscheme melange')
        end
    },
}
