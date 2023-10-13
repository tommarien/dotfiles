return {
    {
        'edeneast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                transparent = true,
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
                duskfox = {
                    NormalFloat = { bg = 'NONE' },
                }
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)

            local palette = require('nightfox.palette').load('duskfox')

            vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = palette.pink.bright, bg = palette.bg1 })
            vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = palette.cyan.bright, bg = palette.bg1 })

            vim.cmd('colorscheme duskfox')
        end
    },
}
