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
    use 'tpope/vim-sleuth'

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
      requires = { { 'nvim-lua/plenary.nvim' }, { 'kyazdani42/nvim-web-devicons' } },
      config = function()
        require('diffview').setup({
          use_icons = true,
        })
      end
    }

    -- Language
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      tag = '*',
    }

    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
      requires = "nvim-treesitter/nvim-treesitter",
    })

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
        require('setup.null-ls')
      end
    }

    use {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    }

    use({
      'hrsh7th/nvim-cmp',
      config = function()
        require('setup.cmp')
      end,
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
      config = function()
        require('setup.lspconfig')
      end,
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
      config = function ()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end
    }

    -- Utilities
    use { 'stevearc/dressing.nvim' }

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
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('setup.lualine')
      end
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
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = function ()
        require("package-info").setup()
      end
    })

    use {
      'akinsho/toggleterm.nvim',
      tag = '*',
      config = function()
        require('setup.toggleterm')
      end
    }

    use {
      'folke/which-key.nvim',
      tag = '*',
      config = function()
        require('setup.which-key')
      end
    }

    use({
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
        require('rose-pine').setup({
          dark_variant = 'moon',
          dim_nc_background = true,
        })
        vim.cmd('colorscheme rose-pine')

        local p = require("rose-pine.palette");

        vim.api.nvim_set_hl(0, 'PackageInfoUpTodateVersion', { fg = p.pine })
        vim.api.nvim_set_hl(0, 'PackageInfoOutdatedVersion', { fg = p.love })
      end
    })

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
            layout_strategy = "horizontal",
            layout_config = { prompt_position = "top" },
            sorting_strategy = "ascending",
            winblend = 0,
          },
          pickers = {
            buffers = {
               previewer = false,
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

    use {
      'ThePrimeagen/harpoon',
      requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
      'folke/zen-mode.nvim',
      config = function()
        require('zen-mode').setup {
          window = {
            width = 140,
            options = {
              number = true,
              relativenumber = true,
            }
          },
        }
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
