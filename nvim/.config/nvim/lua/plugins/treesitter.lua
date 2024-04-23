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
                        max_lines = 4,            -- How many lines the window should span. Values <= 0 mean no limit.
                        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                        line_numbers = true,
                        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
                        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                        -- Separator between context and content. Should be a single character string, like ''.
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

                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = { query = "@class.outer", desc = "Next class start" },
                            --
                            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
                            ["]o"] = "@loop.*",
                            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                            --
                            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    }
                },

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            })
        end
    },
    {
        'Wansmer/treesj',
        keys = {
            { '<leader>m', vim.cmd.TSJToggle, desc = 'Split/Join' },
        },
        opts = {
            max_join_length = 240,
            use_default_keymaps = false,
        },
    }
}
