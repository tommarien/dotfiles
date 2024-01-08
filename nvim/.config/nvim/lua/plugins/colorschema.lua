return {
    {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'atlantis'
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_transparent_background = 2
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            vim.cmd('colorscheme sonokai')

            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
            vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
            vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', fg = '#87ff00', bold = true })
        end
    },
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'colored'
            vim.g.everforest_enable_bold = 1
            -- vim.g.everforest_transparent_background = 1
            -- We set the background to light because i only use the light
            -- vim.opt.background = 'light'
        end
    }
}
