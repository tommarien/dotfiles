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
                    return require('ts_context_commentstring').calculate_commentstring() or vim.bo
                        .commentstring
                end,
            },
        },
    },
    {
        'echasnovski/mini.surround',
        event = 'VeryLazy',
        branch = 'stable',
        opts = {},
    },
    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        branch = 'stable',
        opts = function()
            local spec_treesitter = require('mini.ai').gen_spec.treesitter
            return {
                n_lines = 500,
                custom_textobjects = {
                    c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
                    F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
                    o = spec_treesitter({
                        a = { '@conditional.outer', '@loop.outer' },
                        i = { '@conditional.inner', '@loop.inner' },
                    })
                }
            }
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
        config = true,
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
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
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        i = { ['<c-d>'] = 'delete_buffer' }
                    }
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
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = { use_diagnostic_signs = true },
        keys = {
            { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>',  desc = 'Document Diagnostics (Trouble)' },
            { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
            { '<leader>xL', '<cmd>TroubleToggle loclist<cr>',               desc = 'Location List (Trouble)' },
            { '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>',              desc = 'Quickfix List (Trouble)' },
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
    },
    {
        'max397574/better-escape.nvim',
        event = 'VeryLazy',
        opts = {
            clear_empty_lines = true,
        },
    }
}
