return {
    {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'atlantis'
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_transparent_background = 2
            vim.g.sonokai_diagnostic_virtual_text = 'colored'
            -- vim.cmd('colorscheme sonokai')

            -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
            -- vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
            -- vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', fg = '#87ff00', bold = true })
        end
    },
    {
        'sainnhe/everforest',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 'colored'
            vim.g.everforest_enable_bold = 1
            -- vim.g.everforest_transparent_background = 1
            -- We set the background to light because i only use the light
            -- vim.opt.background = 'light'
        end
    },
    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'edge',
                callback = function()
                    if vim.o.background == 'dark' then
                        vim.cmd('colorscheme edge')

                        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
                        vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
                        vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', fg = '#87ff00', bold = true })
                        vim.api.nvim_set_hl(0, 'TSVariable', { fg = '#c5cdd9' })
                    else
                        vim.g.edge_transparent_background = 0
                    end
                end,
            })

            vim.g.edge_style = 'aura'
            vim.g.edge_better_performance = 1
            vim.g.edge_diagnostic_virtual_text = 'colored'
            vim.g.edge_enable_bold = 1
            vim.g.edge_transparent_background = 2

            -- vim.cmd('colorscheme edge')
        end
    },
    {
        'edeneast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                transparent = true,
                styles = {
                    comments = 'italic',
                    conditionals = 'italic',
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
                    EyelinerPrimary = { bg = 'bg1', fg = '#a4be8B' },
                    -- EyelinerSecondary = { fg = 'bg1', bg = 'diag.error' },
                    NormalFloat = { bg = 'NONE' },
                },
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)

            local variant = 'duskfox';
            vim.cmd('colorscheme ' .. variant)

            local palette = require('nightfox.palette').load(variant)

            vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { undercurl = true, sp = palette.magenta.base })
        end
    }
}
