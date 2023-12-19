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
                    EyelinerPrimary = { link = 'IncSearch' },
                    EyelinerSecondary = { fg = 'bg1', bg = 'diag.error' },
                    TreesitterContext = { bg = 'bg1' },
                    NormalFloat = { bg = 'NONE' },
                },
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)
            -- vim.cmd('colorscheme duskfox')
        end
    },
    {
        'neanias/everforest-nvim',
        version = false,
        lazy = false,
        priority = 1000,
        opts = {
            on_highlights = function(hl, palette)
                hl.EyelinerPrimary = { bg = palette.green, fg = palette.bg1 }
                hl.EyelinerSecondary = { bg = palette.orange, fg = palette.bg1 }
            end
        },
        config = function(_, opts)
            -- vim.cmd('set background=light')
            -- require("everforest").setup(opts)
            -- vim.cmd('colorscheme everforest')
        end,
    },
    {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'atlantis'
            vim.g.sonokai_diagnostic_virtual_text = 'highlighted'
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_better_performance = 1
            vim.cmd('set background=dark')
            vim.cmd('colorscheme sonokai')
        end
    },
}
