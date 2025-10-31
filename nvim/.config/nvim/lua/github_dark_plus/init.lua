local M = {}

M.setup = function()
    vim.o.termguicolors = true
    vim.g.colors_name = 'github_dark_plus'

    vim.cmd('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    local groups = require('github_dark_plus.groups').setup()
    for group, setting in pairs(groups) do
        vim.api.nvim_set_hl(0, group, setting)
    end
end

return M
