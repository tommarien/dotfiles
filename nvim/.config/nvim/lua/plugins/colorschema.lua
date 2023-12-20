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
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'atlantis'
            vim.g.sonokai_diagnostic_virtual_text = 'highlighted'
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_enable_italic = 1
            -- vim.cmd('set background=dark')
            -- vim.cmd('colorscheme sonokai')
        end
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_diagnostic_virtual_text = 'highlighted'
            vim.g.gruvbox_material_transparent_background = 1
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_background = 'soft'
            vim.g.gruvbox_material_better_performance = 1
            -- vim.cmd('set background=dark')
            -- vim.cmd('colorscheme gruvbox-material')
        end
    },
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
            require('catppuccin').setup(opts)
            vim.cmd('colorscheme catppuccin')
        end

    }
}
