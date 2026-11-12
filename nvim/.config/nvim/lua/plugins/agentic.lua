-- sidekick ignores `focus` for external (rex) panes, so focus the attached one ourselves
local function send_and_focus(opts)
    require('sidekick.cli').send(opts)
    vim.defer_fn(function()
        local state = require('sidekick.cli.state').get({ attached = true })[1]
        local block = state and state.session.rex_block_id
        if block then
            vim.system({ 'rex', '-s', vim.env.REX_SESSION, 'focus', block })
        end
    end, 50)
end

return {
    {
        'linw1995/nvim-mcp',
        build = 'cargo install --path .',
        enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= 'true',
        opts = {},
    },
    {
        'folke/sidekick.nvim',
        dependencies = {
            "tommarien/sidekick-rex.nvim",
        },
        config = function(_, opts)
            require("sidekick-rex").setup()
            require("sidekick").setup(opts)
            -- sidekick doesn't focus external (rex) panes, so do it on attach
            vim.api.nvim_create_autocmd('User', {
                pattern = 'SidekickCliAttach',
                callback = function(ev)
                    local block = (ev.data.id or ''):match('^rex (.+)$')
                    if block then
                        vim.system({ 'rex', '-s', vim.env.REX_SESSION, 'focus', block })
                    end
                end,
            })
        end,
        opts = {
            -- add any options here
            nes = {
                enabled = false,
            },
            cli = {
                tools = {
                    -- nvim-mcp sockets are named nvim-mcp.<project>.<pid>.sock; lets claude pick the right nvim
                    claude = { env = { NVIM_PID = tostring(vim.fn.getpid()) } },
                },
                mux = {
                    enabled = true,
                    backend = vim.env.REX_SESSION and "rex" or "tmux",
                    create = "split",
                    split = { size = 0.3 },
                },
            },
        },
        keys = {
            {
                '<leader>ac',
                function() require('sidekick.cli').select({ filter = { installed = true } }) end,
                desc = 'Select CLI',
            },
            {
                '<leader>af',
                function() send_and_focus({ msg = '{file}' }) end,
                desc = 'Send File',
            },
            {
                '<leader>at',
                function() send_and_focus({ msg = '{this}' }) end,
                mode = { 'x', 'n' },
                desc = 'Send This',
            },
            {
                '<leader>ap',
                function() require('sidekick.cli').prompt() end,
                mode = { 'n', 'x' },
                desc = 'Sidekick Select Prompt',
            },
            {
                '<leader>aa',
                function() require('sidekick.cli').toggle({ name = 'claude' }) end,
                desc = 'Sidekick Toggle Claude',
            },
        },
    },
    -- {
    --     'carlos-algms/agentic.nvim',
    --     enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= 'true',
    --     --- @type agentic.PartialUserConfig
    --     opts = {
    --         provider = 'claude-agent-acp', -- setting the name here is all you need to get started
    --         keymaps = {
    --             widget = {
    --                 change_thought_level = "<localLeader>e", -- change to whatever you prefer
    --             },
    --         },
    --         windows = {
    --             width = '25%',
    --         },
    --     },
    --     keys = {
    --         {
    --             '<leader>aa',
    --             function() require('agentic').toggle() end,
    --             mode = { 'n' },
    --             desc = 'Toggle Agentic Chat'
    --         },
    --         {
    --             '<leader>af',
    --             function() require('agentic').add_selection_or_file_to_context() end,
    --             mode = { 'n', 'v' },
    --             desc = 'Add file or selection to Agentic to Context'
    --         },
    --         {
    --             '<leader>at',
    --             function() require('agentic').add_selection_or_file_to_context() end,
    --             mode = { 'n', 'v' },
    --             desc = 'Add file or selection to Agentic to Context'
    --         },
    --         {
    --             '<leader>ac',
    --             function() require('agentic').new_session() end,
    --             mode = { 'n' },
    --             desc = 'New Agentic Session'
    --         },
    --         {
    --             '<leader>ar', -- ai Restore
    --             function()
    --                 require('agentic').restore_session()
    --             end,
    --             mode = { 'n' },
    --             desc = 'Agentic Restore session',
    --             silent = true,
    --         },
    --         {
    --             '<leader>ad', -- ai Diagnostics
    --             function()
    --                 require('agentic').add_current_line_diagnostics()
    --             end,
    --             desc = 'Add current line diagnostic to Agentic',
    --             mode = { 'n' },
    --         },
    --         {
    --             '<leader>aD', -- ai all Diagnostics
    --             function()
    --                 require('agentic').add_buffer_diagnostics()
    --             end,
    --             desc = 'Add all buffer diagnostics to Agentic',
    --             mode = { 'n' },
    --         },
    --         {
    --             "<leader>as",
    --             function()
    --                 require("agentic").stop_generation()
    --             end,
    --             desc = "Stop agent generation",
    --         },
    --     },
    -- }
}
