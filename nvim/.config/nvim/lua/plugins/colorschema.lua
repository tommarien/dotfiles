return {
    {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'andromeda'
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            -- vim.g.sonokai_enable_italic = 1
            vim.cmd('colorscheme sonokai')
        end
    }
}
