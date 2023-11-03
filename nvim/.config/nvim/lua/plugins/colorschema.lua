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
                    EyelinerPrimary = { link = 'Search' },
                    EyelinerSecondary = { fg = 'bg1', bg = 'diag.error' },
                    NormalFloat = { bg = 'NONE' },
                },
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)
            -- vim.cmd('colorscheme dawnfox')
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        opts = {
            disable_italics = true,
            highlight_groups = {
                Comment = { fg = 'muted', italic = true },
                EyelinerPrimary = { link = 'IncSearch' },
                EyelinerSecondary = { link = 'Search' },
                TreesitterContextBottom = { underline = true }
            }
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)

            vim.cmd('colorscheme rose-pine-dawn')
        end
    },
}
