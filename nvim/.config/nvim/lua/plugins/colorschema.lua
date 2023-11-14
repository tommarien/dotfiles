return {
    {
        'edeneast/nightfox.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            options = {
                -- transparent = true,
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
                    EyelinerPrimary = { link = 'Search' },
                    EyelinerSecondary = { fg = 'bg1', bg = 'diag.error' },
                    NormalFloat = { bg = 'NONE' },
                },
            }
        },
        config = function(_, opts)
            require('nightfox').setup(opts)
            -- vim.cmd('colorscheme dawnfox')
        end
    },
    {
        'rmehri01/onenord.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            theme = nil,     -- "dark" or "light". Alternatively, remove the option and set vim.o.background instead
            borders = true,  -- Split window borders
            fade_nc = false, -- Fade non-current windows, making them more distinguishable
            -- Style that is applied to various groups: see `highlight-args` for options
            styles = {
                comments = "italic",
                strings = "NONE",
                keywords = "NONE",
                functions = "NONE",
                variables = "NONE",
                diagnostics = "undercurl",
            },
            disable = {
                background = false,       -- Disable setting the background color
                float_background = false, -- Disable setting the background color for floating windows
                cursorline = false,       -- Disable the cursorline
                eob_lines = true,         -- Hide the end-of-buffer lines
            },
            -- Inverse highlight for different groups
            inverse = {
                match_paren = false,
            },
            custom_highlights = {
                EyelinerPrimary = { link = 'IncSearch' },
                EyelinerSecondary = { link = 'Search' },
            },
            custom_colors = {}, -- Overwrite default colors
        },
        config = function(_, opts)
            require('onenord').setup(opts)

            vim.cmd('colorscheme onenord')
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority = 1000,
        opts = {
            disable_italics = true,
            highlight_groups = {
                Comment = {
                    fg = 'muted',
                    italic = true,
                },
                EyelinerPrimary = { link = 'IncSearch' },
                EyelinerSecondary = { link = 'Search' },
                TreesitterContext = { bg = 'overlay' },
                TreesitterContextBottom = { underline = true, sp = 'iris' },
            }
        },
        config = function(_, opts)
            require('rose-pine').setup(opts)

            -- vim.cmd('colorscheme rose-pine-dawn')
        end
    },
}
