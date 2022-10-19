" General Settings {{{
set nowrap                                              " Never wrap

" Search
set nohlsearch                                          " Never highlight all search matches
set incsearch                                           " Search for strings incrementally

" Tabs and spaces
set autoindent                                          " Auto-indent new lines
set expandtab                                           " Use spaces instead of tabs
set shiftwidth=4                                        " Number of auto-indent spaces
set smartindent                                         " Enable smart-indent
set smarttab                                            " Enable smart-tabs
set softtabstop=4                                       " Number of spaces per Tab

" General editing improvements
set clipboard=unnamedplus                               " Copy to clipboard by default
let mapleader = " "                                     " map leader to Space

if !exists('g:vscode')
    set termguicolors                                   " Enables 24-bit RGB color

    set completeopt=menu,menuone,noinsert,noselect      " Set completeopt to have a better completion experience
    set shortmess+=c                                    " Avoid showing extra messages when using completion
    set scrolloff=8                                     " Scroll 8 lines up or below
    set number                                          " Show line numbers
    set relativenumber                                  " Show relative line numbers 
    set signcolumn=yes                                  " Show sign column
    
    " netrw options
    let g:netrw_winsize = 25
    let g:netrw_banner = 0
endif

" }}} General Settings

" Plugs {{{
call plug#begin('~/.vim/plugged')

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Lua Caching
Plug 'lewis6991/impatient.nvim', Cond(!exists('g:vscode'))

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'gpanders/editorconfig.nvim', Cond(!exists('g:vscode'))
Plug 'jose-elias-alvarez/null-ls.nvim', Cond(!exists('g:vscode'))

Plug 'kyazdani42/nvim-web-devicons', Cond(!exists('g:vscode'))
Plug 'nvim-lua/popup.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-lua/plenary.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'jlanzarotta/bufexplorer', Cond(!exists('g:vscode'))
" Git
Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode'))
Plug 'lewis6991/gitsigns.nvim', Cond(!exists('g:vscode'))
Plug 'sindrets/diffview.nvim', Cond(!exists('g:vscode'))

" General look and feel
Plug 'nvim-lualine/lualine.nvim', Cond(!exists('g:vscode'))
Plug 'lukas-reineke/indent-blankline.nvim', Cond(!exists('g:vscode'))
Plug 'akinsho/toggleterm.nvim', Cond(!exists('g:vscode'))
Plug 'folke/which-key.nvim', Cond(!exists('g:vscode'))

" Themes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Lsp and language options
Plug 'williamboman/mason.nvim', Cond(!exists('g:vscode'))
Plug 'williamboman/mason-lspconfig.nvim', Cond(!exists('g:vscode'))
Plug 'neovim/nvim-lspconfig', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-nvim-lsp', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-buffer', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-path', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-cmdline', Cond(!exists('g:vscode'))
Plug 'hrsh7th/nvim-cmp', Cond(!exists('g:vscode'))
Plug 'dcampos/nvim-snippy', Cond(!exists('g:vscode'))
Plug 'dcampos/cmp-snippy', Cond(!exists('g:vscode'))
Plug 'honza/vim-snippets', Cond(!exists('g:vscode'))

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'rust-lang/rust.vim', Cond(!exists('g:vscode'))
Plug 'simrat39/rust-tools.nvim', Cond(!exists('g:vscode'))

Plug 'b0o/schemastore.nvim', Cond(!exists('g:vscode'))
call plug#end()
" }}} Plugs

" After {{{
if !exists('g:vscode')

lua require('impatient')

" catppuccin {{{
let g:catppuccin_flavour = "macchiato"
lua << EOF
require("catppuccin").setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        mason = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    }
})
EOF
" }}} catppuccin

colorscheme catppuccin
highlight Comment cterm=italic gui=italic

" lualine {{{
lua <<EOF
require('lualine').setup({
 options = {
    icons_enabled = true,
    theme = "catppuccin"
  },
})
EOF
" }}} lualine

" gitsigns {{{
lua <<EOF
require('gitsigns').setup()
EOF
" }}} gitsigns

" mason {{{
lua << EOF
require("mason").setup()
require("mason-lspconfig").setup()
EOF
" }}} mason

" treesitter {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "rust", "typescript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
EOF
" }}} treesitter

" WhichKey {{{
lua << EOF
  local wk = require'which-key'

  wk.setup({})

  wk.register({
  f = {
    name = "file", -- optional group name
    b = "Open buffers", -- Telescope
    f = "Find file", -- Telescope
    r = "Open recent file", -- Telescope
    s = "Search string", -- Telescope
    w = "Search word under cursor", -- Telescope
  },
}, { prefix = "<leader>" })

EOF
" }}} WhichKey

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>

" Configure LSP
lua <<EOF

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- json
nvim_lsp.jsonls.setup {
    capabilities = capabilities,
    settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
    },
}

-- yaml
nvim_lsp.yamlls.setup {
    capabilities = capabilities
    }

-- typescript
nvim_lsp.tsserver.setup {
    capabilities = capabilities
}

-- rust
require('rust-tools').setup {
    capabilities = capabilities
}

EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <leader>e      <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> [d    <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d    <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>q      <cmd>lua vim.diagnostic.setloclist()<CR>

nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <leader>D      <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Quick-fix
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>lf     <cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>
nnoremap <leader>lF     <cmd>lua vim.lsp.buf.range_formatting()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        require('snippy').expand_snippet(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'snippy' },
  }, {
      { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" null-ls {{{
lua << EOF
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.code_actions.eslint,
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.rustfmt,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end
                    })
                end,
            })
        end
    end,
})
EOF
" }}} null-ls

" toggleterm {{{
lua << EOF
require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-`>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, 
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
        border = "Normal",
        background = "Normal",
        },
    },
})
EOF
" }}} toggleterm

" diffview {{{
lua << EOF
require("diffview").setup({
    use_icons = true,    
})
EOF
" }}} diffview

endif
" }}} After
