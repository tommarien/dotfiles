return {
    {
        'tommarien/github-plus.nvim',
        -- dir = '~/Projects/tommarien/github-plus.nvim',
        lazy = false,
        priority = 1000,
        version = false,
        --- @type GithubPlus.Overrides
        opts = {
            semantic = true,
            transparent = true,
        },
        config = function(_, opts)
            require('github_plus').setup(opts)
            -- vim.cmd('colorscheme github_plus')
        end
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath('cache') .. '/github-theme',
                    compile_file_suffix = '_compiled', -- Compiled file suffix
                    hide_end_of_buffer = true,         -- Hide the '~' character at the end of the buffer for a cleaner look
                    hide_nc_statusline = true,         -- Override the underline style for non-active statuslines
                    transparent = false,               -- Disable setting bg (make neovim's background transparent)
                    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false,              -- Non focused panes set to alternative background
                    module_default = true,             -- Default enable value for modules
                    styles = {                         -- Style to be applied to different syntax groups
                        comments = 'italic',           -- Value is any valid attr-list value `:help attr-list`
                        functions = 'NONE',
                        keywords = 'NONE',
                        variables = 'NONE',
                        conditionals = 'NONE',
                        constants = 'NONE',
                        numbers = 'NONE',
                        operators = 'NONE',
                        strings = 'NONE',
                        types = 'NONE',
                    },
                    inverse = { -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    darken = { -- Darken floating windows and sidebar-like windows
                        floats = false,
                        sidebars = {
                            enable = false,
                        },
                    },
                },
                groups = {
                    github_dark_default = {
                        CursorLine = { bg = '#2d323b' },
                    }
                },
                specs = {
                    github_dark_default = {
                        -- bg1 = '#282c33',
                        -- bg1 = '#0d1117',
                        -- bg1 = '#1a1e25'
                        bg1 = '#161b22'
                    }
                },
            })
            vim.cmd('colorscheme github_dark_default')
        end,
    }
}
