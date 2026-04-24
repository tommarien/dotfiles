-- Enable neovim's ui2
require('vim._core.ui2').enable()

-- Temp workaround
vim.hl = vim.highlight

require('options')
require('keymaps')
require('autocmds')
require('commands')
require('filetypes')
require('diagnostics')
require('windows')
require('plugin-manager')
