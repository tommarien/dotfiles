return {
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
                    conditionals = 'bold',
                    constants = 'NONE',
                    functions = 'NONE',
                    keywords = 'italic',
                    numbers = 'NONE',
                    operators = 'NONE',
                    strings = 'NONE',
                    types = 'NONE',
                    variables = 'NONE',
                },
            },
            groups = {
                all = {
                    EyelinerPrimary = { bg = 'bg1', fg = 'palette.green.bright' },
                    EyelinerSecondary = { bg = 'bg1', fg = 'palette.red.bright' },
                    NormalFloat = { bg = 'NONE' },
                    ['@type.qualifier'] = { link = 'keyword' }
                },
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)

            local variant = 'duskfox';
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = '*fox',
                callback = function()
                    local palette = require('nightfox.palette').load(variant)
                    vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { undercurl = true, sp = palette.magenta.base })
                end,
            })

            -- vim.cmd('colorscheme ' .. variant)
        end
    },
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            italic_comments = true,
        },
        config = function(_, opts)
            require('vscode').setup(opts)

            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'vscode',
                callback = function()
                    vim.api.nvim_set_hl(0, 'MatchParen', { bg = 'NONE', fg = '#87ff00', bold = true })
                end,
            })

            vim.cmd('colorscheme vscode')
        end
    },
}
