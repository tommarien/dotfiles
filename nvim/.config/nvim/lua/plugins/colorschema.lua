return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'macchiato',
            transparent_background = true,
            integrations = {
                aerial = true,
                fidget = true,
                mason = true,
                neotest = true,
                harpoon = true,
                which_key = true,
                treesitter_context = true,
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { 'italic' },
                        hints = { 'italic' },
                        warnings = { 'italic' },
                        information = { 'italic' },
                    },
                    underlines = {
                        errors = { 'undercurl' },
                        hints = { 'undercurl' },
                        warnings = { 'undercurl' },
                        information = { 'undercurl' },
                    },
                    inlay_hints = {
                        background = true,
                    },
                },
            },
            styles = {
                comments = { 'italic' },
                conditionals = { 'italic' },
                loops = { 'italic' },
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                operators = {},
            },
            custom_highlights = function(colors)
                return {
                    Comment = { fg = colors.subtext0 },
                    MatchParen = { fg = '#87ff00', style = { 'bold' } },
                    TreesitterContext = { bg = colors.dim },
                    TreesitterContextLineNumber = {
                        fg = colors.surface2,
                        bg = colors.dim,
                    },
                }
            end
        },
        config = function(_, opts)
            -- require('catppuccin').setup(opts)
            -- vim.cmd('colorscheme catppuccin')
        end

    },
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                transparent = true,
                styles = {
                    comments = 'italic',
                    conditionals = 'italic'
                },
            },
            groups = {
                github_dark = {
                    MatchParen = { fg = '#87ff00', style = { 'bold' } },
                    TreesitterContextLineNumber = { bg = 'palette.accent.subtle' }
                }
            }
        },
        config = function(_, opts)
            require('github-theme').setup(opts)

            vim.cmd('colorscheme github_dark')
        end,
    }
}
