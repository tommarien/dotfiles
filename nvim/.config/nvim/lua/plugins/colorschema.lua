return {
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
            -- require('ayu').setup(opts)
            -- vim.cmd('colorscheme ayu')
        end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
        },
        config = function(_, opts)
            require('kanagawa').setup(opts)
            vim.cmd('colorscheme kanagawa')
        end
    },
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000,
        opts = {
            transparent_mode = true,
            contrast = 'hard',
            italic = {
                strings = false
            }
        },
        config = function(_, opts)
            require('gruvbox').setup(opts)
            -- vim.cmd('colorscheme gruvbox')
        end
    }
}
