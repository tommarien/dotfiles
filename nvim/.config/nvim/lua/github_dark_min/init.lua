local config = require('github_dark_min.config')
local palette = require('github_dark_min.palette')
local M = {}

--- @param opts? GithubDarkMin.Overrides
M.setup = function(opts)
    config.setup(opts)

    vim.o.termguicolors = true
    vim.g.colors_name = 'github_dark_min'

    vim.cmd('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    local groups = require('github_dark_min.groups').setup(palette, config.opts)
    for group, setting in pairs(groups) do
        vim.api.nvim_set_hl(0, group, setting)
    end

    if config.opts.terminal_colors then
        require('github_dark_min.terminal').set_terminal_colors(palette)
    end
end

return M
