local o = vim.o

o.termguicolors = true -- Enable 24 bit RGB colors

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Editor ux
o.number = true -- Show line numbers
o.relativenumber = true -- Show relative line numbers, enables easy up,down jumping
o.signcolumn = 'yes' -- Show sign column

o.wrap = false -- Never wrap
o.autoindent = true -- Auto indent new lines
o.expandtab = true -- Use spaces instead of tabs
o.smartindent = true
o.smarttab = true
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used

-- Set completeopt to have a better completion experience
vim.o.completeopt="menu,menuone,preview,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Search
o.hlsearch = false -- Never highlight all search matches
o.incsearch = true -- Search for strings incrementally

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Stable buffer content on window open/close events.
o.splitkeep = 'screen'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Map <leader> to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0

vim.cmd.colorscheme('catppuccin-macchiato')
