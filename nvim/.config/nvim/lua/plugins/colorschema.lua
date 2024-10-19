return {
    {
        'sainnhe/everforest',
        event = 'VeryLazy',
        config = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 1
        end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none'
                        }
                    }
                },
            },
            overrides = function(colors)
                -- print(vim.inspect(colors))
                return {
                    ['@lsp.mod.readonly'] = { link = '@lsp' },
                    ['@repeat'] = { fg = colors.theme.syn.keyword, italic = true },
                    ['@conditional'] = { fg = colors.theme.syn.keyword, italic = true },
                    ['@exception'] = { fg = colors.theme.syn.keyword, italic = true },
                }
            end,
            keywordStyle = { italic = false },
            transparent = false,
        },
        config = function(_, opts)
            require('kanagawa').setup(opts)
            vim.cmd('colorscheme kanagawa')
        end,
    }
}
