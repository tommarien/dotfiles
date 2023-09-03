return {
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true
    },
    {
        'echasnovski/mini.comment',
        event = 'VeryLazy',
        branch = 'stable',
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo
                        .commentstring
                end,
            },
        },
    },
    {
        'echasnovski/mini.surround',
        branch = 'stable',
        opts = {},
    },
    {
        'echasnovski/mini.ai',
        branch = 'stable',
        config = function()
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            require('mini.ai').setup({
                custom_textobjects = {
                    c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
                    F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
                    o = spec_treesitter({
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    })
                }
            })
        end
    },
    {
        'smjonas/live-command.nvim',
        version = '*',
        config = function()
            require('live-command').setup {
                commands = {
                    Norm = { cmd = 'norm' },
                    S = { cmd = 'Subvert' },
                },
            }
        end
    },
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        keys = {
            { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree' },
        },
    },
    'tpope/vim-abolish',
    'christoomey/vim-tmux-navigator',
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {
        'vuki656/package-info.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = function()
            require('package-info').setup({
                autostart = false,
            })
        end
    },
    {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
            },
        },
        config = function()
            local telescope = require 'telescope';

            telescope.setup({
                defaults = {
                    layout_strategy = 'horizontal',
                    layout_config = { prompt_position = 'top' },
                    sorting_strategy = 'ascending',
                    winblend = 0,
                },
                pickers = {
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        mappings = {
                            i = { ['<c-d>'] = 'delete_buffer' }
                        }
                    }
                }
            });

            telescope.load_extension('live_grep_args');
            telescope.load_extension('fzf');
        end
    },
}
