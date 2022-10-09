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

    set completeopt=menuone,noinsert,noselect           " Set completeopt to have a better completion experience
    set shortmess+=c                                    " Avoid showing extra messages when using completion
    set scrolloff=8                                     " Scroll 8 lines up or below
    set number                                          " Show line numbers
    set relativenumber                                  " Show relative line numbers 
    set signcolumn=yes                                  " Show sign column
endif

" }}} General Settings

" Plugs {{{
call plug#begin('~/.vim/plugged')

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'gpanders/editorconfig.nvim', Cond(!exists('g:vscode'))
Plug 'sbdchd/neoformat', Cond(!exists('g:vscode'))

Plug 'nvim-lua/popup.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-lua/plenary.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'EdenEast/nightfox.nvim', Cond(!exists('g:vscode'))

Plug 'lewis6991/gitsigns.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-lualine/lualine.nvim', Cond(!exists('g:vscode'))

Plug 'neovim/nvim-lspconfig', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-nvim-lsp', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-buffer', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-path', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-vsnip', Cond(!exists('g:vscode'))
Plug 'hrsh7th/nvim-cmp', Cond(!exists('g:vscode'))
Plug 'hrsh7th/vim-vsnip', Cond(!exists('g:vscode'))

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'rust-lang/rust.vim', Cond(!exists('g:vscode'))
Plug 'simrat39/rust-tools.nvim', Cond(!exists('g:vscode'))

call plug#end()
" }}} Plugs

" After {{{
if !exists('g:vscode')

colorscheme duskfox

" lualine {{{
lua <<EOF
require('lualine').setup({
 options = {
    icons_enabled = false,
    theme = 'auto',
  },
})
EOF
" }}} lualine

" gitsigns {{{
lua <<EOF
require('gitsigns').setup()
EOF
" }}} gitsigns

" neoformat {{{
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
" }}} neoformat

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

nnoremap <leader>fs <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ps <cmd>lua require('telescope.builtin').live_grep()<cr>

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
}

require('rust-tools').setup(opts)

-- typescript
nvim_lsp.tsserver.setup {}

EOF

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
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
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

endif
" }}} After
