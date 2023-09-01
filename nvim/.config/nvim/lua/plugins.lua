local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'edeneast/nightfox.nvim',
        priority = 1000,
    },
    {
        'echasnovski/mini.comment',
        branch = 'stable',
        config = function()
            require('mini.comment').setup()
        end
    },
    {
        'echasnovski/mini.surround',
        branch = 'stable',
        config = function()
            require('mini.surround').setup()
        end
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
        'NeogitOrg/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('neogit').setup({
                integrations = {
                    diffview = true,
                }
            })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        version = '*',
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('diffview').setup({
                use_icons = true,
                enhanced_diff_hl = true,
                keymaps = {
                    file_panel = {
                        ['q'] = "<Cmd>DiffviewClose<CR>",
                    },
                }
            })
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        version = '*',
        event = { 'BufReadPost', 'BufNewFile' },
        build = ':TSUpdate',
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
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
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
    {
        'williamboman/mason.nvim',
        version = '*',
    },
    {
        'williamboman/mason-lspconfig.nvim',
        version = '*',
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-lspconfig.nvim',
            'folke/neodev.nvim',
            'simrat39/rust-tools.nvim',
            'b0o/schemastore.nvim',
            'mattn/efm-langserver'
        },
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
    'mbbill/undotree',
    'tpope/vim-abolish',
    'christoomey/vim-tmux-navigator',
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
    },
    {

        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        config = function()
            require 'fidget'.setup({
                window = {
                    blend = 0,
                },
            })
        end
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
        version = '*',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('crates').setup {
            }
        end,
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        version = '*',
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-live-grep-args.nvim' },
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
})

-- local packer_bootstrap = ensure_packer()
-- return require('packer').startup({
--     function(use)
--
--         -- Language
--         use {
--             'nvim-treesitter/nvim-treesitter',
--             tag = '*',
--             run = ':TSUpdate',
--         }
--
--         use({
--             "nvim-treesitter/nvim-treesitter-textobjects",
--             after = "nvim-treesitter",
--             requires = "nvim-treesitter/nvim-treesitter",
--         })
--
--         use 'nvim-treesitter/nvim-treesitter-context'
--
--         use {
--             'williamboman/mason.nvim',
--             tag = '*',
--         }
--
--         use {
--             'williamboman/mason-lspconfig.nvim',
--             tag = '*',
--         }
--
--         use({
--             'hrsh7th/nvim-cmp',
--             requires = {
--                 'onsails/lspkind.nvim',
--                 'hrsh7th/cmp-nvim-lsp',
--                 'hrsh7th/cmp-buffer',
--                 'hrsh7th/cmp-path',
--                 'hrsh7th/cmp-cmdline',
--                 'saadparwaiz1/cmp_luasnip',
--                 'L3MON4D3/LuaSnip',
--                 'rafamadriz/friendly-snippets',
--             },
--         })
--
--         use({
--             'neovim/nvim-lspconfig',
--             after = {
--                 'mason-lspconfig.nvim',
--             },
--             requires = {
--                 {
--                     'folke/neodev.nvim',
--                     'simrat39/rust-tools.nvim',
--                     'b0o/schemastore.nvim',
--                     'mattn/efm-langserver'
--                 },
--             },
--         })
--
--         -- Debugging
--         use {
--             'rcarriga/nvim-dap-ui',
--             requires = { 'mfussenegger/nvim-dap' },
--             config = function()
--                 local dap, dapui = require('dap'), require('dapui')
--                 dap.listeners.after.event_initialized['dapui_config'] = function()
--                     dapui.open()
--                 end
--                 dap.listeners.before.event_terminated['dapui_config'] = function()
--                     dapui.close()
--                 end
--                 dap.listeners.before.event_exited['dapui_config'] = function()
--                     dapui.close()
--                 end
--             end
--         }
--
--         -- Utilities
--         use {
--             'smjonas/live-command.nvim',
--             tag = '*',
--             config = function()
--                 require('live-command').setup {
--                     commands = {
--                         Norm = { cmd = 'norm' },
--                         S = { cmd = 'Subvert' },
--                     },
--                 }
--             end
--         }
--
--         use 'mbbill/undotree'
--
--         use {
--             'tpope/vim-abolish',
--         }
--
--         use {
--             'christoomey/vim-tmux-navigator',
--         }
--
--         use {
--             'ThePrimeagen/harpoon',
--             requires = 'nvim-lua/plenary.nvim',
--         }
--
--         use {
--
--             'nvim-lualine/lualine.nvim',
--             requires = { 'nvim-tree/nvim-web-devicons' },
--         }
--
--         use {
--             'j-hui/fidget.nvim',
--             tag = 'legacy',
--             config = function()
--                 require 'fidget'.setup({
--                     window = {
--                         blend = 0,
--                     },
--                 })
--             end
--         }
--
--         use({
--             'vuki656/package-info.nvim',
--             requires = 'MunifTanjim/nui.nvim',
--             config = function()
--                 require('package-info').setup({
--                     autostart = false,
--                 })
--             end
--         })
--
--         use {
--             'saecki/crates.nvim',
--             tag = '*',
--             requires = 'nvim-lua/plenary.nvim',
--             config = function()
--                 require('crates').setup {
--                 }
--             end,
--         }
--
--         use {
--             'folke/which-key.nvim',
--             tag = '*',
--         }
--
--
--         use {
--             'nvim-telescope/telescope.nvim',
--             requires = {
--                 { 'nvim-lua/plenary.nvim' },
--                 { 'nvim-telescope/telescope-live-grep-args.nvim' },
--             }
--         }
--
--         use { 'nvim-telescope/telescope-fzf-native.nvim', run =
--         'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
--
--         -- Automatically set up your configuration after cloning packer.nvim
--         -- Put this at the end after all plugins
--         if packer_bootstrap then
--             require('packer').sync()
--         end
--     end,
--     config = {
--         display = {
--             open_fn = function()
--                 return require('packer.util').float({ border = 'single' })
--             end
--         }
--     }
-- })
