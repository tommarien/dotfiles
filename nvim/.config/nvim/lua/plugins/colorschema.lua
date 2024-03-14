return {
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 1
            -- vim.cmd('colorscheme everforest')
        end
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_background = 'soft'
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 1
            vim.cmd('colorscheme gruvbox-material')
        end
    },
}
