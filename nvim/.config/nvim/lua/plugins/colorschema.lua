return {
    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.edge_style = 'aura'
            vim.g.edge_better_performance = 1
            vim.g.edge_diagnostic_virtual_text = 'colored'
            vim.g.edge_enable_bold = 1
            vim.g.edge_transparent_background = 0

            -- vim.cmd('colorscheme edge')
        end
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'storm',
            styles = {
                floats = 'normal',
                keywords = { italic = false },
            },
            lualine_bold = true,
        },
        config = function(_, opts)
            require('tokyonight').setup(opts)
            -- vim.cmd('colorscheme tokyonight')
        end
    },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        opts = {
            -- contrast = 'soft',
            overrides = {
                SignColumn = { link = 'LineNr' },
            }
        },
        config = function(_, opts)
            require('gruvbox').setup(opts)
            vim.cmd('colorscheme gruvbox')
        end
    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup({
                -- ...
            })
        end,
    },
    {
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000,
        config = function()
            require('everforest').setup({
            })
        end,
    }
}
