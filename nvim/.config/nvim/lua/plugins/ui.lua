return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = function()
            local copilotColors = {
                [''] = 'Normal',
                ['Normal'] = 'DiagnosticOk',
                ['Warning'] = 'DiagnosticError',
                ['InProgress'] = 'DiagnosticWarn',
            }

            return
            {
                options = {
                    icons_enabled = true,
                    theme = 'auto'
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            newfile_status = true,
                            path = 1,
                        },
                    },
                    lualine_x = {
                        'encoding',
                        'fileformat',
                        'filetype',
                        {
                            function()
                                local status = require('copilot.api').status.data

                                return ' ' .. (status.message or '')
                            end,
                            cnd = function()
                                local ok, clients = pcall(vim.lsp.get_active_clients, { name = 'copilot', bufnr = 0 })
                                print(ok, clients);
                                return ok and #clients > 0
                            end,
                            color = function()
                                if not package.loaded['copilot'] then
                                    return
                                end
                                local status = require('copilot.api').status.data
                                return copilotColors[status.status] or copilotColors['']
                            end
                        }
                    },
                },
            }
        end
    },
    {
        'echasnovski/mini.hipatterns',
        event = 'VeryLazy',
        version = '*',
        config = function()
            local hipatterns = require('mini.hipatterns')
            hipatterns.setup({
                highlighters = {
                    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end
    },
    {
        'stevearc/qf_helper.nvim',
        event = 'VeryLazy',
        keys = {
            { ']q', vim.cmd.QNext, desc = 'Next QF/LL entry' },
            { '[q', vim.cmd.QPrev, desc = 'Prev QF/LL entry' },
        },
        opts = {}
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        version = '*',
        init = function()
            local wk = require('which-key')

            wk.register({
                b = {
                    name = 'Buffer',
                    d = { '<cmd>bd<cr>', 'Delete buffer' },
                    n = { '<cmd>bn<cr>', 'Next buffer' },
                    p = { '<cmd>bp<cr>', 'Previous buffer' },
                    r = { '<cmd>Telescope buffers<cr>', 'Open recent buffer' },
                    s = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search buffer' },
                },
                f = {
                    name = 'File',
                    b = { '<cmd>Telescope buffers<cr>', 'Open buffers' },
                    d = { '<cmd>Telescope diagnostics<cr>', 'Search diagnostics' },
                    f = { '<cmd>Telescope find_files<cr>', '[F]ind [F]iles' },
                    g = { '<cmd>Telescope git_files<cr>', '[F]ind [G]it files' },
                    r = { '<cmd>Telescope oldfiles<cr>', '[F]ind [R]ecent files' },
                    s = { '<cmd>Telescope live_grep_args<cr>', 'Search string' },
                    w = { '<cmd>Telescope grep_string<cr>', 'Search word under cursor' },
                },
                h = { name = 'Harpoon' },
                p = {
                    name = 'Packages',
                    s = { function() require('package-info').show() end, 'Show dependency versions' },
                    c = { function() require('package-info').hide() end, 'Hide dependency versions' },
                    t = { function() require('package-info').toggle() end, 'Toggle dependency versions' },
                    u = { function() require('package-info').update() end, 'Update dependency on the line' },
                    d = { function() require('package-info').delete() end, 'Delete dependency on the line' },
                    i = { function() require('package-info').install() end, 'Install a new dependency' },
                    p = { function() require('package-info').change_version() end, 'Install a different version' },
                },
                t = {
                    name = 'Crates',
                    t = { function() require('crates').toggle() end, 'Toggle' },
                    r = { function() require('crates').reload() end, 'Reload' },
                    v = { function() require('crates').show_versions_popup() end, 'Show versions' },
                    f = { function() require('crates').show_features_popup() end, 'Show features' },
                    d = { function() require('crates').show_dependencies_popup() end, 'Show dependencies' },
                    s = { function() require('crates').focus_popup() end, 'Focus popup' },
                    u = { function() require('crates').update_crate() end, 'Update crate' },
                    U = { function() require('crates').upgrade_crate() end, 'Upgrade crate' },
                }
            }, { prefix = '<leader>' })

            wk.register({
                B = { '<cmd>bfirst<cr>', 'First buffer' },
                b = { '<cmd>bprev<cr>', 'Previous buffer' },
                h = { function() require('harpoon.ui').nav_prev() end, 'Previous harpoon mark' },
            }, { prefix = '[' })

            wk.register({
                B = { '<cmd>blast<cr>', 'Last buffer' },
                b = { '<cmd>bnext<cr>', 'Next buffer' },
                h = { function() require('harpoon.ui').nav_next() end, 'Next harpoon mark' },
            }, { prefix = ']' })
        end,
        opts = {}
    },
    {
        'folke/zen-mode.nvim',
        cmd = 'ZenMode',
        keys = {
            { '<leader>zz', vim.cmd.ZenMode, desc = 'ZenMode' },
        },
        opts = {},
    }
}
