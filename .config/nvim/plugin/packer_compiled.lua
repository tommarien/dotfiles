-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/tommarien/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/tommarien/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/tommarien/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/tommarien/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/tommarien/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["crates.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\nœ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\fkeymaps\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\2\21enhanced_diff_hl\2\14use_icons\2\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\nblend\3\0\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    config = { "\27LJ\2\nû\4\0\0\6\0\30\0#'\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\4\6\3=\0\a\0034\4\0\0=\4\b\0035\4\n\0005\5\t\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\0045\5\16\0=\5\17\0045\5\18\0=\5\19\0045\5\20\0=\5\21\0045\5\22\0=\5\23\0045\5\24\0=\5\25\4=\4\26\3B\1\2\0016\1\27\0009\1\28\1'\3\29\0B\1\2\1K\0\1\0\24colorscheme gruvbox\bcmd\bvim\14overrides\20GruvboxAquaSign\1\0\1\abg\5\20GruvboxBlueSign\1\0\1\abg\5\19GruvboxRedSign\1\0\1\abg\5\22GruvboxYellowSign\1\0\1\abg\5\22GruvboxPurpleSign\1\0\1\abg\5\22GruvboxOrangeSign\1\0\1\abg\5\21GruvboxGreenSign\1\0\1\abg\5\15SignColumn\1\0\0\1\0\1\tlink\vNormal\22palette_overrides\rcontrast\vitalic\1\0\4\rcomments\2\fstrings\2\nfolds\2\14operators\1\1\0\v\finverse\2\25invert_intend_guides\1\19invert_tabline\1\17invert_signs\1\21invert_selection\1\18strikethrough\2\17dim_inactive\1\21transparent_mode\1\tbold\2\14underline\2\14undercurl\2\nsetup\fgruvbox\frequire\5\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  harpoon = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["live-command.nvim"] = {
    config = { "\27LJ\2\nn\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\rcommands\1\0\0\tNorm\1\0\0\1\0\1\bcmd\tnorm\nsetup\17live-command\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/live-command.nvim",
    url = "https://github.com/smjonas/live-command.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\ncloseÌ\1\1\0\4\0\r\0\0236\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0009\2\4\0029\2\5\0023\3\a\0=\3\6\0029\2\3\0009\2\b\0029\2\t\0023\3\n\0=\3\6\0029\2\3\0009\2\b\0029\2\v\0023\3\f\0=\3\6\0022\0\0€K\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\ndapui\bdap\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tmux-navigation"] = {
    config = { "\27LJ\2\nÁ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\16keybindings\1\0\6\aup\n<C-k>\16last_active\n<C-\\>\tdown\n<C-j>\tnext\14<C-Space>\tleft\n<C-h>\nright\n<C-l>\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-tmux-navigation",
    url = "https://github.com/alexghergh/nvim-tmux-navigation"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["oil.nvim"] = {
    config = { "\27LJ\2\n“\1\0\0\a\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\0\0'\6\1\0B\4\2\0029\4\b\0045\5\t\0B\0\5\1K\0\1\0\1\0\1\tdesc\26Open parent directory\topen\6-\6n\bset\vkeymap\bvim\nsetup\boil\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/oil.nvim",
    url = "https://github.com/stevearc/oil.nvim"
  },
  ["package-info.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\14autostart\1\nsetup\17package-info\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/package-info.nvim",
    url = "https://github.com/vuki656/package-info.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope-lsp-handlers.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/telescope-lsp-handlers.nvim",
    url = "https://github.com/gbrlsnchs/telescope-lsp-handlers.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÂ\3\0\0\b\0\22\0\0306\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\r\0005\5\b\0005\6\n\0005\a\t\0=\a\v\6=\6\f\5=\5\14\0045\5\15\0=\5\16\4=\4\17\3B\1\2\0019\1\18\0'\3\19\0B\1\2\0019\1\18\0'\3\20\0B\1\2\0019\1\18\0'\3\21\0B\1\2\1K\0\1\0\15fzy_native\17lsp_handlers\19live_grep_args\19load_extension\fpickers\15find_files\1\0\1\14previewer\1\fbuffers\1\0\0\rmappings\6i\1\0\0\1\0\1\n<c-d>\18delete_buffer\1\0\3\14previewer\1\18sort_lastused\2\21show_all_buffers\2\rdefaults\1\0\0\18layout_config\1\0\1\20prompt_position\btop\1\0\3\21sorting_strategy\14ascending\20layout_strategy\15horizontal\rwinblend\3\0\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  undotree = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/Users/tommarien/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tmux-navigation
time([[Config for nvim-tmux-navigation]], true)
try_loadstring("\27LJ\2\nÁ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\16keybindings\1\0\6\aup\n<C-k>\16last_active\n<C-\\>\tdown\n<C-j>\tnext\14<C-Space>\tleft\n<C-h>\nright\n<C-l>\1\0\1\24disable_when_zoomed\2\nsetup\25nvim-tmux-navigation\frequire\0", "config", "nvim-tmux-navigation")
time([[Config for nvim-tmux-navigation]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1À\ncloseÌ\1\1\0\4\0\r\0\0236\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0009\2\4\0029\2\5\0023\3\a\0=\3\6\0029\2\3\0009\2\b\0029\2\t\0023\3\n\0=\3\6\0029\2\3\0009\2\b\0029\2\v\0023\3\f\0=\3\6\0022\0\0€K\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\ndapui\bdap\frequire\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: live-command.nvim
time([[Config for live-command.nvim]], true)
try_loadstring("\27LJ\2\nn\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\rcommands\1\0\0\tNorm\1\0\0\1\0\1\bcmd\tnorm\nsetup\17live-command\frequire\0", "config", "live-command.nvim")
time([[Config for live-command.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nÂ\3\0\0\b\0\22\0\0306\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\3\0005\5\4\0=\5\5\4=\4\a\0035\4\r\0005\5\b\0005\6\n\0005\a\t\0=\a\v\6=\6\f\5=\5\14\0045\5\15\0=\5\16\4=\4\17\3B\1\2\0019\1\18\0'\3\19\0B\1\2\0019\1\18\0'\3\20\0B\1\2\0019\1\18\0'\3\21\0B\1\2\1K\0\1\0\15fzy_native\17lsp_handlers\19live_grep_args\19load_extension\fpickers\15find_files\1\0\1\14previewer\1\fbuffers\1\0\0\rmappings\6i\1\0\0\1\0\1\n<c-d>\18delete_buffer\1\0\3\14previewer\1\18sort_lastused\2\21show_all_buffers\2\rdefaults\1\0\0\18layout_config\1\0\1\20prompt_position\btop\1\0\3\21sorting_strategy\14ascending\20layout_strategy\15horizontal\rwinblend\3\0\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: oil.nvim
time([[Config for oil.nvim]], true)
try_loadstring("\27LJ\2\n“\1\0\0\a\0\n\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0006\4\0\0'\6\1\0B\4\2\0029\4\b\0045\5\t\0B\0\5\1K\0\1\0\1\0\1\tdesc\26Open parent directory\topen\6-\6n\bset\vkeymap\bvim\nsetup\boil\frequire\0", "config", "oil.nvim")
time([[Config for oil.nvim]], false)
-- Config for: gruvbox.nvim
time([[Config for gruvbox.nvim]], true)
try_loadstring("\27LJ\2\nû\4\0\0\6\0\30\0#'\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\4\6\3=\0\a\0034\4\0\0=\4\b\0035\4\n\0005\5\t\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\0045\5\16\0=\5\17\0045\5\18\0=\5\19\0045\5\20\0=\5\21\0045\5\22\0=\5\23\0045\5\24\0=\5\25\4=\4\26\3B\1\2\0016\1\27\0009\1\28\1'\3\29\0B\1\2\1K\0\1\0\24colorscheme gruvbox\bcmd\bvim\14overrides\20GruvboxAquaSign\1\0\1\abg\5\20GruvboxBlueSign\1\0\1\abg\5\19GruvboxRedSign\1\0\1\abg\5\22GruvboxYellowSign\1\0\1\abg\5\22GruvboxPurpleSign\1\0\1\abg\5\22GruvboxOrangeSign\1\0\1\abg\5\21GruvboxGreenSign\1\0\1\abg\5\15SignColumn\1\0\0\1\0\1\tlink\vNormal\22palette_overrides\rcontrast\vitalic\1\0\4\rcomments\2\fstrings\2\nfolds\2\14operators\1\1\0\v\finverse\2\25invert_intend_guides\1\19invert_tabline\1\17invert_signs\1\21invert_selection\1\18strikethrough\2\17dim_inactive\1\21transparent_mode\1\tbold\2\14underline\2\14undercurl\2\nsetup\fgruvbox\frequire\5\0", "config", "gruvbox.nvim")
time([[Config for gruvbox.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\nœ\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\fkeymaps\15file_panel\1\0\0\1\0\1\6q\27<Cmd>DiffviewClose<CR>\1\0\2\21enhanced_diff_hl\2\14use_icons\2\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\vwindow\1\0\0\1\0\1\nblend\3\0\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n]\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\0\1\0\1\rdiffview\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: package-info.nvim
time([[Config for package-info.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\14autostart\1\nsetup\17package-info\frequire\0", "config", "package-info.nvim")
time([[Config for package-info.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd mason-lspconfig.nvim ]]
vim.cmd [[ packadd nvim-lspconfig ]]
vim.cmd [[ packadd nvim-treesitter ]]
vim.cmd [[ packadd nvim-treesitter-textobjects ]]
time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
