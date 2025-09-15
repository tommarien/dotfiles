vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight Normal guibg=none')
        vim.cmd('highlight ColorColumn guibg=#282826')
        vim.cmd('highlight Comment guifg=#9d8b78')
        vim.cmd('highlight GitSignsCurrentLineBlame guifg=#7d6b58')
        vim.cmd('highlight LspReferenceText guibg=#383128 gui=none')
        vim.cmd('highlight MatchParen guibg=#413a30')
        vim.cmd('highlight NormalFloat guibg=none')
        vim.cmd('highlight Spellbad guifg=none guisp=#bd8183')
        vim.cmd('highlight String gui=none')

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = '#7d6b58',
            bg = 'NONE'
        })

        vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {
            fg = '#a89984', -- Dimmed color from melange palette
            italic = true,
            undercurl = true,
            sp = '#928374' -- Subtle underline
        })
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
    }
}
