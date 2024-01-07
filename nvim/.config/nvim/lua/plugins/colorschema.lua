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
            -- vim.cmd('colorscheme sonokai')
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
    },
    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'neon'
            vim.g.edge_better_performance = 1
            vim.g.edge_diagnostic_virtual_text = 'colored'
            vim.g.edge_enable_bold = 1
            -- vim.g.edge_transparent_background = 1
            vim.cmd('colorscheme edge')
        end
    },
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            -- transparent = true,
        },
        config = function(_, opts)
            require('bamboo').setup(opts)
            -- vim.cmd('colorscheme bamboo')
        end,
    },
}
