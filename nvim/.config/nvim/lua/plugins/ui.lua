return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        enabled = not vim.g.vscode,
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
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'brenoprata10/nvim-highlight-colors',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        opts = {
            render = 'virtual'
        }
    },
    {
        'preservim/vimux',
        enabled = not vim.g.vscode,
        event = 'VeryLazy',
        config = function()
            -- vimux config
            vim.g.VimuxUseNearest = 0  -- never steal an existing pane (sidekick's)
            vim.g.VimuxCloseOnExit = 1 -- clean up vimux's own pane on exit
        end,
    },
    {
        'nvim-mini/mini.files',
        version = '*',
        opts = {
            mappings = {
                -- This opens the file, but quits out of mini.files (default L)
                go_in_plus = "<CR>",
                -- I swapped the following 2 (default go_out: h)
                -- go_out_plus: when you go out, it shows you only 1 item to the right
                -- go_out: shows you all the items to the right
                go_out = "H",
                go_out_plus = "h",
            }
        },
        config = function(_, opts)
            require("mini.files").setup(opts)
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local function entry_dir()
                        local entry = require("mini.files").get_fs_entry()
                        if not entry then return vim.uv.cwd() end
                        return entry.fs_type == "directory" and entry.path or vim.fn.fnamemodify(entry.path, ":h")
                    end

                    vim.keymap.set("n", "`", function()
                        local dir = entry_dir()
                        vim.api.nvim_set_current_dir(dir)
                        vim.notify("cwd: " .. dir, vim.log.levels.INFO)
                    end, { buffer = args.data.buf_id, desc = "Set cwd to current directory" })
                end,
            })
        end,
        keys = {
            {
                -- Open the directory of the file currently being edited
                -- If the file doesn't exist because you maybe switched to a new git branch
                -- open the current working directory
                "-",
                function()
                    local buf_name = vim.api.nvim_buf_get_name(0)
                    local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")

                    if vim.fn.filereadable(buf_name) == 1 then
                        -- Pass the full file path to highlight the file
                        require("mini.files").open(buf_name, true)
                    elseif vim.fn.isdirectory(dir_name) == 1 then
                        -- If the directory exists but the file doesn't, open the directory
                        require("mini.files").open(dir_name, true)
                    else
                        -- If neither exists, fallback to the current working directory
                        require("mini.files").open(vim.uv.cwd(), true)
                    end
                end,
                desc = "Open mini.files (Directory of Current File or CWD if not exists)",
            },
            {
                '<leader>@',
                function()
                    require("mini.files").open(vim.uv.cwd(), true)
                end,
                desc = "Open mini.files (cwd)",
            }
        },
    },
    {
        'stevearc/quicker.nvim',
        enabled = not vim.g.vscode,
        event = 'VeryLazy',
        keys = {
            { ']q', vim.cmd.cnext, desc = 'Next QF/LL entry' },
            { '[q', vim.cmd.cprev, desc = 'Prev QF/LL entry' },
        },
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        version = '*',
        opts = {
            preset = 'modern'
        },
        config = function(_, opts)
            local wk = require('which-key')

            wk.add({
                -- buffers
                { '<leader>b',       group = 'Buffer' },
                { '<leader>bd',      '<cmd>bd<cr>',                                                                 desc = 'Delete buffer' },
                { '<leader>bn',      '<cmd>bn<cr>',                                                                 desc = 'Next buffer' },
                { '<leader>bp',      '<cmd>bp<cr>',                                                                 desc = 'Previous buffer' },
                { '<leader>br',      function() Snacks.picker.buffers() end,                                        desc = 'Open recent buffer' },
                { '<leader>bs',      function() Snacks.picker.lines() end,                                          desc = 'Search buffer' },
                { '[b',              '<cmd>bprev<cr>',                                                              desc = 'Previous buffer' },
                { '[B',              '<cmd>bfirst<cr>',                                                             desc = 'First buffer' },
                { ']b',              '<cmd>bnext<cr>',                                                              desc = 'Next buffer' },
                { ']B',              '<cmd>blast<cr>',                                                              desc = 'Last buffer' },

                -- files
                { '<leader>f',       group = 'File' },
                { '<leader>fb',      function() Snacks.picker.buffers() end,                                        desc = 'Open buffers' },
                { '<leader>fd',      function() Snacks.picker.diagnostics() end,                                    desc = 'Search diagnostics' },
                { '<leader><space>', function() Snacks.picker.files() end,                                          desc = '[F]ind [F]iles' },
                { '<leader>ff',      function() require('fff').find_files() end,                                    desc = '[F]ind [F]iles' },
                { '<leader>fg',      function() Snacks.picker.git_files() end,                                      desc = '[F]ind [G]it files' },
                { '<leader>fh',      function() Snacks.picker.help() end,                                           desc = '[F]ind [H]elp' },
                { '<leader>fr',      function() Snacks.picker.recent({ filter = { cwd = true } }) end,              desc = '[F]ind [R]ecent files' },
                { '<leader>fs',      function() require('fff').live_grep() end,                                     desc = 'Search string' },
                { '<leader>fS',      function() Snacks.picker.grep() end,                                           desc = 'Search string' },
                { '<leader>fw',      function() require('fff').live_grep({ query = vim.fn.expand('<cword>') }) end, desc = 'Search word under cursor' },
                { '<leader>fS',      function() Snacks.picker.lsp_workspace_symbols() end,                          desc = 'Search symbol' },

                -- harpoon
                { '<leader>h',       group = 'Harpoon' },
                { '[h',              function() require('harpoon.ui').nav_prev() end,                               desc = 'Previous harpoon mark' },
                { ']h',              function() require('harpoon.ui').nav_next() end,                               desc = 'Next harpoon mark' },

                -- packages
                { '<leader>p',       group = 'Packages' },
                { '<leader>ps',      function() require('package-info').show() end,                                 desc = 'Show dependency versions' },
                { '<leader>pc',      function() require('package-info').hide() end,                                 desc = 'Hide dependency versions' },
                { '<leader>pt',      function() require('package-info').toggle() end,                               desc = 'Toggle dependency versions' },
                { '<leader>pu',      function() require('package-info').update() end,                               desc = 'Update dependency on the line' },
                { '<leader>pd',      function() require('package-info').delete() end,                               desc = 'Delete dependency on the line' },
                { '<leader>pi',      function() require('package-info').install() end,                              desc = 'Install a new dependency' },
                { '<leader>pp',      function() require('package-info').change_version() end,                       desc = 'Install a different version' },
            })

            wk.setup(opts)
        end,
    },
}
