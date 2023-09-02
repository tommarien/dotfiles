return {
    {
        'edeneast/nightfox.nvim',
        priority = 1000,
        lazy = false,
        init = function()
            vim.cmd('colorscheme duskfox')
        end,
        opts = {
            options = {
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
        }
    },
}
