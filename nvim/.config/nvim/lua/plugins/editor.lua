return {
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true
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
        'echasnovski/mini.surround',
        event = 'VeryLazy',
        version = '*',
        opts = {},
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
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
        opts = {
            highlight_on_key = true,
            dim = true,
        }
    },
    {
        'stevearc/conform.nvim',
        event = 'VeryLazy',
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>F',
                function()
                    require('conform').format({ async = true, lsp_fallback = true })
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
                    return { timeout_ms = 500, lsp_fallback = true }
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
                require('conform').format({ async = true, lsp_fallback = true, range = range })
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
        event = 'VeryLazy'
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
        'ThePrimeagen/harpoon',
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
        event = { 'BufRead package.json' },
        dependencies = 'MunifTanjim/nui.nvim',
        opts = {
            autostart = false,
        },
        config = true,
    },
    {
        'nvim-telescope/telescope.nvim',
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
                }
            }
        },
        config = function(_, opts)
            local telescope = require 'telescope';
            telescope.setup(opts);

            telescope.load_extension('live_grep_args');
            telescope.load_extension('fzf');
        end
    },
    {
        'folke/trouble.nvim',
        cmd = { 'Trouble' },
        opts = { use_diagnostic_signs = true },
        keys = {
            { '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',                desc = 'Document Diagnostics (Trouble)' },
            { '<leader>xX', '<cmd>Trouble diagnostics toggle<cr>',                             desc = 'Workspace Diagnostics (Trouble)' },
            { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                                 desc = 'Location List (Trouble)' },
            { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                                  desc = 'Quickfix List (Trouble)' },
            { '<leader>o',  '<cmd>Trouble lsp_document_symbols toggle win.position=right<cr>', desc = 'Document Symbols(Trouble)' },
            {
                '[q',
                function()
                    if require('trouble').is_open() then
                        require('trouble').previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = 'Previous trouble/quickfix item',
            },
            {
                ']q',
                function()
                    if require('trouble').is_open() then
                        require('trouble').next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = 'Next trouble/quickfix item',
            },
        },
    }
}
