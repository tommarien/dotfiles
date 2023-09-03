-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Make definition and signature_help bordered
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
})

-- Set diagnostics signs
local sign = function(o)
    vim.fn.sign_define(o.name, {
        texthl = o.name,
        text = o.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '󰅚 ' })
sign({ name = 'DiagnosticSignWarn', text = '󰀪 ' })
sign({ name = 'DiagnosticSignHint', text = '󰌶 ' })
sign({ name = 'DiagnosticSignInfo', text = '󰋽 ' })

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = {
            {
                options = {
                    icons_enabled = true,
                    theme = "auto"
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            newfile_status = true,
                            path = 1,
                        },
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                },
            }
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        version = '*',
        init = function()
            local wk = require('which-key')

            local harpoonMap = {
                name = 'Harpoon',
                s = { function() require("harpoon.ui").toggle_quick_menu() end, "Show menu" },
                a = { function() require("harpoon.mark").add_file() end, "Add mark" },
            }

            for i = 1, 4 do
                harpoonMap[tostring(i)] = { function() require("harpoon.ui").nav_file(i) end, "Navigate to mark " .. i }
            end

            wk.register({
                b = {
                    name = "Buffer",
                    d = { "<cmd>bd<cr>", "Delete buffer" },
                    n = { "<cmd>bn<cr>", "Next buffer" },
                    p = { "<cmd>bp<cr>", "Previous buffer" },
                    r = { "<cmd>Telescope buffers<cr>", "Open recent buffer" },
                    s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search buffer" },
                },
                f = {
                    name = "File",
                    b = { "<cmd>Telescope buffers<cr>", "Open buffers" },
                    d = { "<cmd>Telescope diagnostics<cr>", "Search diagnostics" },
                    f = { "<cmd>Telescope find_files<cr>", "[F]ind [F]iles" },
                    g = { "<cmd>Telescope git_files<cr>", "[F]ind [G]it files" },
                    r = { "<cmd>Telescope oldfiles<cr>", "[F]ind [R]ecent files" },
                    s = { "<cmd>Telescope live_grep_args<cr>", "Search string" },
                },
                h = harpoonMap,
                p = {
                    name = 'Packages',
                    s = { function() require("package-info").show() end, "Show dependency versions" },
                    c = { function() require("package-info").hide() end, "Hide dependency versions" },
                    t = { function() require("package-info").toggle() end, "Toggle dependency versions" },
                    u = { function() require("package-info").update() end, "Update dependency on the line" },
                    d = { function() require("package-info").delete() end, "Delete dependency on the line" },
                    i = { function() require("package-info").install() end, "Install a new dependency" },
                    p = { function() require("package-info").change_version() end, "Install a different version" },
                },
                c = {
                    name = 'Crates',
                    t = { function() require("crates").toggle() end, "Toggle" },
                    r = { function() require("crates").reload() end, "Reload" },
                    v = { function() require("crates").show_versions_popup() end, "Show versions" },
                    f = { function() require("crates").show_features_popup() end, "Show features" },
                    d = { function() require("crates").show_dependencies_popup() end, "Show dependencies" },
                    s = { function() require("crates").focus_popup() end, "Focus popup" },
                    u = { function() require("crates").update_crate() end, "Update crate" },
                    U = { function() require("crates").upgrade_crate() end, "Upgrade crate" },
                }
            }, { prefix = "<leader>" })

            wk.register({
                B = { "<cmd>bfirst<cr>", "First buffer" },
                b = { "<cmd>bprev<cr>", "Previous buffer" },
                h = { function() require("harpoon.ui").nav_prev() end, "Previous harpoon mark" },
            }, { prefix = "[" })

            wk.register({
                B = { "<cmd>blast<cr>", "Last buffer" },
                b = { "<cmd>bnext<cr>", "Next buffer" },
                h = { function() require("harpoon.ui").nav_next() end, "Next harpoon mark" },
            }, { prefix = "]" })
        end,
        opts = {}
    },
}