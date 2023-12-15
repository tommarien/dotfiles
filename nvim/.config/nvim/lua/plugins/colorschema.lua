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
                    -- TreesitterContext = { bg = 'bg0' },
                    NormalFloat = { bg = 'NONE' },
                },
            }
        },
        config = function(_, opts)
            -- require('nightfox').setup(opts)
            --
            -- local variant = 'duskfox';
            -- vim.cmd('colorscheme ' .. variant)
            --
            -- local palette = require('nightfox.palette').load(variant)
            --
            -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = palette.green.base })
            -- vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { undercurl = true, sp = palette.magenta.base })
        end
    },
    {
        'yorik1984/newpaper.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            italic_strings = false,
            booleans = 'NONE',
            keywords = 'NONE'
        },
        config = function(_, opts)
            require('newpaper').setup(opts)
        end
    }
}
