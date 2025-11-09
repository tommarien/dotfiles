--- @class GithubDarkMin.Config
--- @field opts GithubDarkMin.Options
local M = {}

--- @class GithubDarkMin.Options
--- @field terminal_colors boolean
--- @field transparent boolean
local defaults = {
    terminal_colors = true,
    transparent = false,
}

--- @class GithubDarkMin.Overrides
--- @field transparent? boolean Enable transparent background
--- @field terminal_colors? boolean Apply colors to terminal
--- @param opts? GithubDarkMin.Overrides
M.setup = function(opts)
    M.opts = vim.tbl_extend('force', M.opts, opts or {})
end

M.opts = defaults

return M
