return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        event = 'VeryLazy',
        opts = function()
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
    -- {
    --     'stevearc/oil.nvim',
    --     lazy = false,
    --     opts = {
    --         skip_confirm_for_simple_edits = true,
    --         view_options = {
    --             show_hidden = true,
    --         }
    --     },
    --     keys = {
    --         {
    --             '-',
    --             vim.cmd.Oil,
    --             desc = "Browse containing folder"
    --         }
    --
    --     },
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- },
    {
        'echasnovski/mini.files',
        version = '*',
        lazy = false,
        keys = {
            {
                '-',
                function()
                    local MiniFiles = require('mini.files')
                    MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
                end,
                desc = "Browse containing folder"
            }

        },
        opts = {
            mappings = {
                go_out = '-',
                go_in = '<CR>',
                go_in_plus = '<CR>'
            }
        }
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

            wk.add({
                -- buffers
                { '<leader>b',  group = 'Buffer' },
                { '<leader>bd', '<cmd>bd<cr>',                                  desc = 'Delete buffer' },
                { '<leader>bn', '<cmd>bn<cr>',                                  desc = 'Next buffer' },
                { '<leader>bp', '<cmd>bp<cr>',                                  desc = 'Previous buffer' },
                { '<leader>br', '<cmd>Telescope buffers<cr>',                   desc = 'Open recent buffer' },
                { '<leader>bs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search buffer' },
                { '[b',         '<cmd>bprev<cr>',                               desc = 'Previous buffer' },
                { '[B',         '<cmd>bfirst<cr>',                              desc = 'First buffer' },
                { ']b',         '<cmd>bnext<cr>',                               desc = 'Next buffer' },
                { ']B',         '<cmd>blast<cr>',                               desc = 'Last buffer' },


                -- files
                { '<leader>f',  group = 'File' },
                { '<leader>fb', '<cmd>Telescope buffers<cr>',                   desc = 'Open buffers' },
                { '<leader>fd', '<cmd>Telescope diagnostics<cr>',               desc = 'Search diagnostics' },
                { '<leader>ff', '<cmd>Telescope find_files<cr>',                desc = '[F]ind [F]iles' },
                { '<leader>fg', '<cmd>Telescope git_files<cr>',                 desc = '[F]ind [G]it files' },
                { '<leader>fh', '<cmd>Telescope help_tags<cr>',                 desc = '[F]ind [H]elp' },
                { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                  desc = '[F]ind [R]ecent files' },
                { '<leader>fs', '<cmd>Telescope live_grep_args<cr>',            desc = 'Search string' },
                { '<leader>fw', '<cmd>Telescope grep_string<cr>',               desc = 'Search word under cursor' },
                {
                    '<leader>fw',
                    function()
                        local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
                        live_grep_args_shortcuts.grep_visual_selection()
                    end,
                    desc = 'Search visual selection',
                    mode = 'v'
                },
                { '<leader>fS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',      desc = 'Search symbol' },

                -- harpoon
                { '<leader>h',  group = 'Harpoon' },
                { '[h',         function() require('harpoon.ui').nav_prev() end,         desc = 'Previous harpoon mark' },
                { ']h',         function() require('harpoon.ui').nav_next() end,         desc = 'Next harpoon mark' },

                -- packages
                { '<leader>p',  group = 'Packages' },
                { '<leader>ps', function() require('package-info').show() end,           desc = 'Show dependency versions' },
                { '<leader>pc', function() require('package-info').hide() end,           desc = 'Hide dependency versions' },
                { '<leader>pt', function() require('package-info').toggle() end,         desc = 'Toggle dependency versions' },
                { '<leader>pu', function() require('package-info').update() end,         desc = 'Update dependency on the line' },
                { '<leader>pd', function() require('package-info').delete() end,         desc = 'Delete dependency on the line' },
                { '<leader>pi', function() require('package-info').install() end,        desc = 'Install a new dependency' },
                { '<leader>pp', function() require('package-info').change_version() end, desc = 'Install a different version' },
            })
        end,
        opts = {
            preset = 'modern'
        }
    },
}
