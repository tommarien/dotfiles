return {
    {
        'tpope/vim-sleuth',
        enabled = not vim.g.vscode,
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'chentoast/marks.nvim',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        'max397574/better-escape.nvim',
        event = 'InsertEnter',
        config = function()
            local clearEmptyLines = function()
                vim.api.nvim_input("<esc>")
                local current_line = vim.api.nvim_get_current_line()
                if current_line:match('^%s+j$') then
                    vim.schedule(function()
                        vim.api.nvim_set_current_line('')
                    end)
                end
            end

            require('better_escape').setup({
                k = function()
                    vim.api.nvim_input("<esc>")
                    local current_line = vim.api.nvim_get_current_line()
                    if current_line:match('^%s+j$') then
                        vim.schedule(function()
                            vim.api.nvim_set_current_line('')
                        end)
                    end
                end,
                mappings = {
                    i = {
                        j = {
                            k = clearEmptyLines,
                            j = clearEmptyLines,
                        },
                    },
                    v = {
                        j = {
                            k = false
                        }
                    }
                }
            })
        end
    },
    {
        'echasnovski/mini.comment',
        event = 'VeryLazy',
        version = '*',
        opts = {
            options = {
                custom_commentstring = function()
                    local ts_context_commentstring = require('ts_context_commentstring')

                    return ts_context_commentstring.calculate_commentstring() or vim.bo
                        .commentstring
                end,
            },
        },
    },
    {
        'kylechui/nvim-surround',
        version = '^3.0.0',
        event = 'VeryLazy',
        opts = {}
    },
    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        version = '*',
        opts = function()
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            return {
                n_lines = 500,
                custom_textobjects = {
                    c = spec_treesitter({
                        a = '@class.outer',
                        i = '@class.inner'
                    }),
                    F = spec_treesitter({
                        a = '@function.outer',
                        i = '@function.inner'
                    }),
                    o = spec_treesitter({
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    })
                }
            }
        end
    },
    {
        'jinh0/eyeliner.nvim',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        opts = {
            highlight_on_key = true,
            dim = true,
        }
    },
    {
        'stevearc/conform.nvim',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>F',
                function()
                    require('conform').format({
                        async = true,
                        lsp_fallback = true,
                    })
                end,
                mode = '',
                desc = 'Format buffer',
            },
        },
        opts = function()
            return {
                formatters_by_ft = {
                    css = { 'prettierd' },
                    html = { 'prettierd' },
                    javascript = { 'prettierd' },
                    ["javascript.jsx"] = { 'prettierd' },
                    ["javascriptreact"] = { 'prettierd' },
                    json = { 'prettierd' },
                    jsonc = { 'prettierd' },
                    markdown = { 'prettierd' },
                    scss = { 'prettierd' },
                    typescript = { 'prettierd' },
                    ["typescript.tsx"] = { 'prettierd' },
                    ["typescriptreact"] = { 'prettierd' },
                    yaml = { 'prettierd' }
                },
                format_on_save = function(bufnr)
                    -- Disable with a global or buffer-local variable
                    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                        return
                    end
                    return { timeout_ms = 500, lsp_format = 'fallback' }
                end,
            }
        end,
        init = function()
            vim.api.nvim_create_user_command('Format', function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ['end'] = { args.line2, end_line:len() },
                    }
                end
                require('conform').format({ async = true, lsp_format = 'fallback', range = range })
            end, { range = true })

            vim.api.nvim_create_user_command('FormatDisable', function(args)
                if args.bang then
                    -- FormatDisable! will disable formatting just for this buffer
                    vim.b.disable_autoformat = true
                else
                    vim.g.disable_autoformat = true
                end
            end, {
                desc = 'Disable autoformat-on-save',
                bang = true,
            })

            vim.api.nvim_create_user_command('FormatEnable', function()
                vim.b.disable_autoformat = false
                vim.g.disable_autoformat = false
            end, {
                desc = 'Re-enable autoformat-on-save',
            })
        end
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        enabled = not vim.g.vscode,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            gitbrowse = { enabled = true },
            image = { enabled = true },
            indent = {
                enabled = true,
                scope = {
                    enabled = false
                }
            },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            statuscolumn = {
                enabled = true,
            },
            quickfile = { enabled = true },
        },
        config = function(_, opts)
            require('snacks').setup(opts)
            vim.api.nvim_create_user_command('GitBrowse', function()
                local snacks = require('snacks');
                snacks.gitbrowse()
            end, {
                desc = 'Open the repo of the active file in the browser',
            })
        end
    },
    {
        'stevearc/aerial.nvim',
        enabled = not vim.g.vscode,
        keys = {
            { '<leader>o', vim.cmd.AerialToggle, desc = 'AerialToggle' },
        },
        opts = {
            on_attach = function(bufnr)
                vim.keymap.set('n', '[a', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                vim.keymap.set('n', ']a', '<cmd>AerialNext<CR>', { buffer = bufnr })
            end,
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'smjonas/live-command.nvim',
        event = 'VeryLazy',
        main = 'live-command',
        version = '*',
        opts = {
            commands = {
                Norm = { cmd = 'norm' },
                S = { cmd = 'Subvert' },
            },
        },
    },
    {
        'mbbill/undotree',
        enabled = not vim.g.vscode,
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' },
        },
    },
    {
        'tpope/vim-abolish',
        event = 'VeryLazy',
    },
    {
        'christoomey/vim-tmux-navigator',
        enabled = not vim.g.vscode,
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
            'TmuxNavigatePrevious',
            'TmuxNavigatorProcessList',
        },
        keys = {
            { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },
    {
        'ThePrimeagen/harpoon',
        enabled = not vim.g.vscode,
        keys = {
            { '<leader>ha', function() require("harpoon.mark").add_file() end,        desc = 'Add mark' },
            { '<leader>hs', function() require("harpoon.ui").toggle_quick_menu() end, desc = 'Show marks' },
            { '<leader>h1', function() require("harpoon.ui").nav_file(1) end,         desc = 'Navigate to mark 1' },
            { '<leader>h2', function() require("harpoon.ui").nav_file(2) end,         desc = 'Navigate to mark 2' },
            { '<leader>h3', function() require("harpoon.ui").nav_file(3) end,         desc = 'Navigate to mark 3' },
            { '<leader>h4', function() require("harpoon.ui").nav_file(4) end,         desc = 'Navigate to mark 4' },
        },
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'vuki656/package-info.nvim',
        enabled = not vim.g.vscode,
        event = { 'BufRead package.json' },
        dependencies = 'MunifTanjim/nui.nvim',
        opts = {
            autostart = false,
        },
        config = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        enabled = not vim.g.vscode,
        event = 'VeryLazy',
        version = '*',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        opts = {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = { prompt_position = 'top' },
                sorting_strategy = 'ascending',
                winblend = 0,
            },
            pickers = {
                oldfiles = {
                    cwd_only = true,
                },
                find_files = {
                    previewer = false,
                },
                git_files = {
                    previewer = false,
                },
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        i = { ['<c-d>'] = 'delete_buffer' }
                    }
                },
                lsp_references = {
                    show_line = false,
                },
            }
        },
        config = function(_, opts)
            local telescope = require 'telescope';
            local lga_actions = require("telescope-live-grep-args.actions")

            opts.extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {         -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                }
            }
            telescope.setup(opts);

            telescope.load_extension('live_grep_args');
            telescope.load_extension('fzf');
        end
    },
    {
        url = "https://codeberg.org/andyg/leap.nvim",
        config = function()
            local leap = require('leap')
            -- Highly recommended: define a preview filter to reduce visual noise
            -- and the blinking effect after the first keypress
            -- (`:h leap.opts.preview`). You can still target any visible
            -- positions if needed, but you can define what is considered an
            -- exceptional case.
            -- Exclude whitespace and the middle of alphabetic words from preview:
            --   foobar[baaz] = quux
            --   ^----^^^--^^-^-^--^
            leap.opts.preview = function(ch0, ch1, ch2)
                return not (
                    ch1:match('%s')
                    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
                )
            end

            -- Define equivalence classes for brackets and quotes, in addition to
            -- the default whitespace group:
            leap.opts.equivalence_classes = {
                ' \t\r\n', '([{', ')]}', '\'"`'
            }

            vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
            vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')
        end
    }
}
