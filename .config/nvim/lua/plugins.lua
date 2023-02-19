local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({ function(use)
    use 'wbthomason/packer.nvim'

    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-sleuth'

    -- Git
    use {
      'TimUntersberger/neogit',
      requires = 'nvim-lua/plenary.nvim',
      config = function ()
        require("neogit").setup({
          integrations = {
            diffview = true,
          }
        })
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      tag = '*',
      config = function ()
        require('gitsigns').setup()
      end
    }
    use {
      'sindrets/diffview.nvim',
      requires = {{ 'nvim-lua/plenary.nvim' },{ 'kyazdani42/nvim-web-devicons' }},
      config = function()
        require("diffview").setup({
          use_icons = true,
        })
      end
    }

    -- Language
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      tag = '*',
      config = function ()
        require('setup.treesitter')
      end
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      requires = {{ 'nvim-lua/plenary.nvim' }},
      config = function ()
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
      requires = { 'mfussenegger/nvim-dap' }
    }

    -- Utilities
    use {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard').setup {
          theme = 'hyper',
          config = {
            week_header = {
              enable = true,
            },
            shortcut = {
              { desc = ' Update', group = '@property', action = 'PackerSync', key = 'u' },
            },
          }
        }
      end,
      requires = {'nvim-tree/nvim-web-devicons'}

    }
    use {
      'smjonas/live-command.nvim',
      tag = '*',
      config = function ()
        require("live-command").setup {
          commands = {
            Norm = { cmd = "norm" },
          },
        }
      end
    }

    use {
      'ggandor/leap.nvim',
      config = function ()
        require('leap').add_default_mappings()
      end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function ()
        require('setup.lualine')
      end
    }

    use {
      'j-hui/fidget.nvim',
      config = function ()

        require"fidget".setup({
          window = {
            blend = 0,
          },
        })
      end
    }

    use {
      'akinsho/toggleterm.nvim',
      tag = '*',
      config = function ()
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

    use 'rebelot/kanagawa.nvim'

    use {
      'catppuccin/nvim',
      as = 'catppuccin',
      tag = '*',
      config = function ()
        require('setup.catppuccin')
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      tag = '*',
      requires = {
        {'nvim-lua/plenary.nvim'},
        { "nvim-telescope/telescope-live-grep-args.nvim" },
      },
      config = function()
        require("telescope").load_extension("live_grep_args")
      end
    }

    use {
      'ThePrimeagen/harpoon',
      requires = {{ 'nvim-lua/plenary.nvim' }}
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function ()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
