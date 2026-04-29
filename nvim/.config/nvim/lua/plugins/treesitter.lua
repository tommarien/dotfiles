local languages = {
    'dockerfile',
    'gitcommit',
    'go',
    'latex',
    'lua',
    'mermaid',
    'printf',
    'rust',
    'sql',
    'tmux',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
}

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate',
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
            -- replicate `ensure_installed`, runs asynchronously, skips existing languages
            require('nvim-treesitter').install(languages)

            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter.setup', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match

                    -- you need some mechanism to avoid running on buffers that do not
                    -- correspond to a language (like oil.nvim buffers), this implementation
                    -- checks if a parser exists for the current language
                    local language = vim.treesitter.language.get_lang(filetype) or filetype
                    if not vim.treesitter.language.add(language) then
                        return
                    end

                    -- replicate `fold = { enable = true }`
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                    -- replicate `highlight = { enable = true }`
                    vim.treesitter.start(buf, language)
                end,
            })
        end,
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
