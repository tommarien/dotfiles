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
        'shatur/neovim-ayu',
        lazy = false,
        priority = 1000,
        opts = {
            mirage = true,
            overrides = {
                Normal = { bg = 'None' },
                ColorColumn = { bg = 'None' },
                SignColumn = { bg = 'None' },
                Folded = { bg = 'None' },
                FoldColumn = { bg = 'None' },
                CursorLine = { bg = 'None' },
                CursorColumn = { bg = 'None' },
                VertSplit = { bg = 'None' },
            }
        },
        config = function(_, opts)
            require('ayu').setup(opts)
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
            vim.cmd('set background=light')
            require("everforest").setup(opts)
            vim.cmd('colorscheme everforest')
        end,
    }
}
