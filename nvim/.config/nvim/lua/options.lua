local o = vim.o
local g = vim.g

o.termguicolors = true -- Enable 24 bit RGB colors

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 100

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Editor ux
o.number = true         -- Show line numbers
o.relativenumber = true -- Show relative line numbers, enables easy up,down jumping
o.signcolumn = 'yes'    -- Show sign column
o.wrap = false          -- Never wrap
o.autoindent = true     -- Auto indent new lines
o.expandtab = true      -- Use spaces instead of tabs
o.smartindent = true
o.smarttab = true
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.cursorline = true
o.colorcolumn = '80,120'

-- Set completeopt to have a better completion experience
o.completeopt = "menu,menuone,noselect"

-- Avoid showing message extra message when using completion
o.shortmess = o.shortmess .. "c"

-- Search
o.hlsearch = false -- Never highlight all search matches
o.incsearch = true -- Search for strings incrementally

-- Makes neovim and host OS clipboard play nicely with each other
-- o.clipboard = 'unnamedplus'

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- buffer
o.fillchars = 'eob: '

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- Netrw
-- g.netrw_banner = 0
g.netrw_winsize = 25
g.netrw_browse_split = 0

-- Remap common typos
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Qall! qall!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wa wa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
