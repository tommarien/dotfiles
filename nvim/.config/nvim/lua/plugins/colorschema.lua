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
                all = {
                    EyelinerPrimary = { fg = 'palette.pink.bright', bg = 'NONE' },
                    EyelinerSecondary = { fg = 'palette.cyan.bright', bg = 'NONE' },
                },
                duskfox = {
                    NormalFloat = { bg = 'NONE' },
                }
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)

            vim.cmd('colorscheme duskfox')
        end
    },
}
