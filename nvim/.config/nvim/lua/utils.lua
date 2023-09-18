local utils = {}

-- Functional wrapper for mapping custom keybindings
function utils.map(mode, key, cmd, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, key, cmd, options)
end

-- @alias SignDefinition { name: string, text: string }
-- Set diagnostics signs
-- @param o SignDefinition
function utils.sign(o)
    vim.fn.sign_define(o.name, {
        texthl = o.name,
        text = o.text,
        numhl = ''
    })
end

return utils
