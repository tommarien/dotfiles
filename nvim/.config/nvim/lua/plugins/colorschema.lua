return {
    {
        'edeneast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                -- transparent = true,
                styles = {               -- Style to be applied to different syntax groups
                    comments = 'italic', -- Value is any valid attr-list value `:help attr-list`
                    conditionals = 'NONE',
                    constants = 'NONE',
                    functions = 'NONE',
                    keywords = 'NONE',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE',
                    variables = 'NONE',
                },
            },
            groups = {
                all = {
                    NormalFloat = { bg = 'NONE' },
                },
                dawnfox = {
                    EyelinerPrimary = { fg = 'palette.pink.bright', bg = 'NONE' },
                    EyelinerSecondary = { fg = 'palette.cyan.bright', bg = 'NONE' },
                },
                duskfox = {
                    EyelinerPrimary = { fg = 'palette.pink.bright', bg = 'NONE' },
                    EyelinerSecondary = { fg = 'palette.cyan.bright', bg = 'NONE' },
                }
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)

            vim.cmd('colorscheme dawnfox')
        end
    },
    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'light'
            vim.g.edge_better_performance = 1

            -- vim.cmd('colorscheme edge')

            vim.api.nvim_set_hl(0, 'EyelinerPrimary', { link = 'QuickScopePrimary' })
            vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = '#5079be' })
        end
    }
}
