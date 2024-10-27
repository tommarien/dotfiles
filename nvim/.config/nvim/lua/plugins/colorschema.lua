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
                local theme = colors.theme

                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    ['@lsp.mod.readonly'] = { link = '@lsp' },
                    ['@repeat'] = { fg = theme.syn.keyword },
                    ['@conditional'] = { fg = theme.syn.keyword },
                    ['@exception'] = { fg = theme.syn.keyword },
                }
            end,
            keywordStyle = { italic = false },
            transparent = false,
        },
        config = function(_, opts)
            require('kanagawa').setup(opts)
            vim.cmd('colorscheme kanagawa')
        end,
    },
}
