local leet_arg = "leetcode.nvim"

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
                    return require('ts_context_commentstring').calculate_commentstring() or vim.bo
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
        'kawre/leetcode.nvim',
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = leet_arg ~= vim.fn.argv()[1],
        opts = {
            arg = leet_arg,
        },
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
        'stevearc/aerial.nvim',
        event = 'VeryLazy',
        keys = {
            { '<leader>a', vim.cmd.AerialToggle, desc = 'AerialToggle' },
        },
        opts = {
            on_attach = function(bufnr)
                vim.keymap.set("n", "[a", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "]a", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
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
        opts = {
            clear_empty_lines = true,
        },
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
                }
            }
        },
        config = function(_, opts)
            local telescope = require 'telescope';
            telescope.setup(opts);

            telescope.load_extension('live_grep_args');
            telescope.load_extension('fzf');
        end
    }
}
