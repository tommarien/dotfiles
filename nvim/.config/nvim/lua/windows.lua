-- Monkey patch floating borders
local default_float_border = 'rounded'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or default_float_border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
