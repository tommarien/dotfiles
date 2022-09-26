call plug#begin('~/.vim/plugged')

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

Plug 'rust-lang/rust.vim', Cond(!exists('g:vscode'))

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig', Cond(!exists('g:vscode'))

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp', Cond(!exists('g:vscode'))
" cmp LSP completion
Plug 'hrsh7th/cmp-nvim-lsp', Cond(!exists('g:vscode'))
" cmp Snippet completion
Plug 'hrsh7th/cmp-vsnip', Cond(!exists('g:vscode'))
" cmp Path completion
Plug 'hrsh7th/cmp-path', Cond(!exists('g:vscode'))
Plug 'hrsh7th/cmp-buffer', Cond(!exists('g:vscode'))
" See hrsh7th other plugins for more great completion sources!

" Adds extra functionality over rust analyzer
Plug 'simrat39/rust-tools.nvim', Cond(!exists('g:vscode'))

" Snippet engine
Plug 'hrsh7th/vim-vsnip', Cond(!exists('g:vscode'))

" Optional
Plug 'nvim-lua/popup.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-lua/plenary.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-telescope/telescope.nvim', Cond(!exists('g:vscode'))

" Tree
Plug 'preservim/nerdtree', Cond(!exists('g:vscode'))

" Surround
Plug 'tpope/vim-surround'

" Commentary
Plug 'tpope/vim-commentary'

" Themes
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Status
Plug 'nvim-lualine/lualine.nvim', Cond(!exists('g:vscode'))

" Editor config
Plug 'editorconfig/editorconfig-vim'

" Plug 'chaoren/vim-wordmotion'

call plug#end()

" No ancient limitations
set nocompatible

if !exists('g:vscode')

set termguicolors

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local opts = {
}

require('rust-tools').setup(opts)
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

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" LineNumbers
set number 

" Copy to clipboard by default
set clipboard=unnamedplus

" Setup Lualine
lua << END
require('lualine').setup({
 options = {
    icons_enabled = false,
    theme = 'auto',
  },
})
END

" Setup Catpuccin
lua << EOF
require("catppuccin").setup()
EOF

colorscheme catppuccin

endif 

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs
