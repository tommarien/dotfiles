local M = {}

local defaults = {
    transparent = false,
}

M.setup = function(opts)
    M.opts = vim.tbl_extend('force', M.opts, opts or {})
end

M.opts = defaults

return M
