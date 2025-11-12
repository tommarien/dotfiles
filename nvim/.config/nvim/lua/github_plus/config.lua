--- @class GithubPlus.Config
--- @field opts GithubPlus.Options
local M = {}

--- @class GithubPlus.Options
--- @field terminal_colors boolean
--- @field transparent boolean
local defaults = {
    terminal_colors = true,
    transparent = false,
}

--- @class GithubPlus.Overrides
--- @field transparent? boolean Enable transparent background
--- @field terminal_colors? boolean Apply colors to terminal
--- @param opts? GithubPlus.Overrides
M.setup = function(opts)
    M.opts = vim.tbl_extend('force', M.opts, opts or {})
end

M.opts = defaults

return M
