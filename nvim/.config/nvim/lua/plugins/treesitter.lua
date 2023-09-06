return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = '*',
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { "TSUpdateSync" },
        build = ':TSUpdate',
        keys = {
            { "<M-Down>", desc = "Increment selection" },
            { "<M-Up>",   desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            {
                'nvim-treesitter/nvim-treesitter-context',
                config = function()
                    require 'treesitter-context'.setup {
                        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                        max_lines = 6,            -- How many lines the window should span. Values <= 0 mean no limit.
                        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                        line_numbers = true,
                        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
                        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                        -- Separator between context and content. Should be a single character string, like '-'.
                        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                        separator = nil,
                        zindex = 20,     -- The Z-index of the context window
                        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
                    }
                end,
            }

        },
        config = function()
            require 'nvim-treesitter.configs'.setup({
                -- A list of parser names, or "all"
                ensure_installed = { 'lua', 'rust', 'typescript', 'vim', 'vimdoc' },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                },

                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<M-Down>',
                        node_incremental = '<M-Down>',
                        scope_incremental = false,
                        node_decremental = '<M-Up>',
                    },
                },

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            })
        end
    },
}
