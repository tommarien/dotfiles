local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
    function(use)
        use 'wbthomason/packer.nvim'

        use 'tpope/vim-commentary'
        use({
            'kylechui/nvim-surround',
            tag = '*',
            config = function()
                require('nvim-surround').setup {}
            end
        })

        use {
            'wellle/targets.vim',
            tag = '*'
        }

        -- Git
        use {
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('neogit').setup({
                    integrations = {
                        diffview = true,
                    }
                })
            end
        }

        use {
            'lewis6991/gitsigns.nvim',
            tag = '*',
            config = function()
                require('gitsigns').setup()
            end
        }
        use {
            'sindrets/diffview.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('diffview').setup({
                    use_icons = true,
                })
            end
        }

        -- Language
        use {
            'nvim-treesitter/nvim-treesitter',
            tag = '*',
            run = ':TSUpdate',
        }

        use({
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        })

        use {
            'jose-elias-alvarez/null-ls.nvim',
            requires = 'nvim-lua/plenary.nvim',
        }

        use {
            'williamboman/mason.nvim',
            tag = '*',
        }

        use {
            'williamboman/mason-lspconfig.nvim',
            tag = '*',
        }

        use({
            'hrsh7th/nvim-cmp',
            requires = {
                'onsails/lspkind.nvim',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'saadparwaiz1/cmp_luasnip',
                'L3MON4D3/LuaSnip',
                'rafamadriz/friendly-snippets',
            },
        })

        use({
            'neovim/nvim-lspconfig',
            after = {
                'mason-lspconfig.nvim',
            },
            requires = {
                {
                    'simrat39/rust-tools.nvim',
                    'b0o/schemastore.nvim',
                },
            },
        })

        -- Debugging
        use {
            'rcarriga/nvim-dap-ui',
            requires = { 'mfussenegger/nvim-dap' },
            config = function()
                local dap, dapui = require('dap'), require('dapui')
                dap.listeners.after.event_initialized['dapui_config'] = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated['dapui_config'] = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited['dapui_config'] = function()
                    dapui.close()
                end
            end
        }

        -- Utilities
        use {
            'smjonas/live-command.nvim',
            tag = '*',
            config = function()
                require('live-command').setup {
                    commands = {
                        Norm = { cmd = 'norm' },
                    },
                }
            end
        }

        use {
            'alexghergh/nvim-tmux-navigation',
            config = function()
                require 'nvim-tmux-navigation'.setup {
                    disable_when_zoomed = true, -- defaults to false
                    keybindings = {
                        left = '<C-h>',
                        down = '<C-j>',
                        up = '<C-k>',
                        right = '<C-l>',
                        last_active = '<C-\\>',
                        next = '<C-Space>',
                    }
                }
            end
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
        }

        use {
            'j-hui/fidget.nvim',
            config = function()
                require 'fidget'.setup({
                    window = {
                        blend = 0,
                    },
                })
            end
        }

        use({
            'vuki656/package-info.nvim',
            requires = 'MunifTanjim/nui.nvim',
            config = function()
                require('package-info').setup({
                    autostart = false,
                })
            end
        })

        use {
            'saecki/crates.nvim',
            tag = '*',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('crates').setup {
                }
            end,
        }

        use {
            'akinsho/toggleterm.nvim',
            tag = '*',
        }

        use {
            'folke/which-key.nvim',
            tag = '*',
        }

        use {
            'ellisonleao/gruvbox.nvim',
            config = function()
                require('gruvbox').setup({
                    undercurl = true,
                    underline = true,
                    bold = true,
                    italic = {
                        strings = true,
                        comments = true,
                        operators = false,
                        folds = true,
                    },
                    strikethrough = true,
                    invert_selection = false,
                    invert_signs = false,
                    invert_tabline = false,
                    invert_intend_guides = false,
                    inverse = true, -- invert background for search, diffs, statuslines and errors
                    contrast = '',  -- can be "hard", "soft" or empty string
                    palette_overrides = {},
                    overrides = {
                        SignColumn = { link = "Normal" },
                        GruvboxGreenSign = { bg = "" },
                        GruvboxOrangeSign = { bg = "" },
                        GruvboxPurpleSign = { bg = "" },
                        GruvboxYellowSign = { bg = "" },
                        GruvboxRedSign = { bg = "" },
                        GruvboxBlueSign = { bg = "" },
                        GruvboxAquaSign = { bg = "" },
                    },
                    dim_inactive = false,
                    transparent_mode = false,
                })

                vim.cmd('colorscheme gruvbox')
            end
        }

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-fzy-native.nvim' },
                { 'nvim-telescope/telescope-live-grep-args.nvim' },
                { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
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
                            previewer = false,
                            mappings = {
                                i = { ['<c-d>'] = 'delete_buffer' }
                            }
                        },
                        find_files = {
                            previewer = false,
                        },
                    }
                });

                telescope.load_extension('live_grep_args');
                telescope.load_extension('lsp_handlers');
                telescope.load_extension('fzy_native');
            end
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
