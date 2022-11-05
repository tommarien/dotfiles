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

" change the direction of new splits
set splitbelow
set splitright

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

" Arrow keys

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" }}} General Settings

" Plugs {{{
call plug#begin('~/.vim/plugged')

" Lua Caching
Plug 'lewis6991/impatient.nvim'

Plug 'tpope/vim-surround', { 'tag': 'v2.2' }
Plug 'tpope/vim-commentary'
Plug 'smjonas/live-command.nvim', { 'tag': '1.2.1' }

Plug 'gpanders/editorconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim', { 'tag': 'v0.5' }
Plug 'sindrets/diffview.nvim'

" General look and feel
Plug 'nvim-lualine/lualine.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v2.20.2' }
Plug 'akinsho/toggleterm.nvim'
Plug 'folke/which-key.nvim'

" Themes
Plug 'catppuccin/nvim', { 'as': 'catppuccin', 'tag': 'v0.2.5' }

" Lsp and language options
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

Plug 'b0o/schemastore.nvim'

call plug#end()
" }}} Plugs

" After {{{

" Highlight on yank {{{
lua << EOF
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
EOF
" }}} Highlight on yank

lua require('impatient')

" catppuccin {{{
lua << EOF
require("catppuccin").setup({
    flavour = "macchiato",
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

colorscheme catppuccin-macchiato

" lualine {{{
lua <<EOF
require('lualine').setup({
 options = {
    icons_enabled = true,
    theme = "auto"
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
      name = "file",
      b = { "<cmd>Telescope buffers theme=get_ivy<cr>", "Open buffers" },
      f = { "<cmd>Telescope find_files theme=get_ivy<cr>", "Find file" },
      r = { "<cmd>Telescope oldfiles theme=get_ivy<cr>", "Open recent file" },
      s = { "<cmd>Telescope live_grep theme=get_ivy<cr>", "Search string" },
      w = { "<cmd>Telescope grep_string theme=get_ivy<cr>", "Search word under cursor" },
  }
  }, { prefix = "<leader>" })

  wk.register({
  B = { "<cmd>bfirst<cr>", "First buffer" },
  b = { "<cmd>bprev<cr>", "Previous buffer" },
  }, { prefix = "["}) 

  wk.register({
  B = { "<cmd>blast<cr>", "Last buffer" },
  b = { "<cmd>bnext<cr>", "Next buffer" },
  }, { prefix = "]"}) 

EOF
" }}} WhichKey

" Configure LSP
lua <<EOF

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

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
    on_attach = on_attach,
}

-- yaml
nvim_lsp.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- typescript
nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- rust
require('rust-tools').setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Make definition and signature_help bordered
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
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
require("luasnip/loaders/from_vscode").lazy_load()

local cmp = require'cmp'
local luasnip = require 'luasnip'

local kind_icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

cmp.setup({
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, vim_item)
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
        return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  -- Installed sources
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, 
      { name = 'buffer' },
  }),
  matching = {
    disallow_fuzzy_matching = false,
  },
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

local null_ls = require("null-ls");

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rustfmt,
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

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ' '})
sign({name = 'DiagnosticSignWarn', text = ' '})
sign({name = 'DiagnosticSignHint', text = ' '})
sign({name = 'DiagnosticSignInfo', text = ' '})

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
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

" live-command {{{
lua << EOF
require("live-command").setup {
    commands = {
        Norm = { cmd = "norm" },
    },
}
EOF
" }}} live-command

" }}} After
