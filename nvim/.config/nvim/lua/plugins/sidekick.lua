return {
    {
        'folke/sidekick.nvim',
        opts = {
            -- add any options here
            nes = {
                enabled = false,
            },
            cli = {
                mux = {
                    backend = 'tmux',
                    enabled = true,
                    create = 'split',
                    split = {
                        size = 0.3, -- size of the split (0-1 for percentage)
                    },
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
                '<leader>ad',
                function() require('sidekick.cli').close() end,
                desc = 'Detach a CLI Session',
            },
            {
                '<leader>af',
                function()
                    require('sidekick.cli').send({ msg = '{file}' })
                end,
                desc = 'Send File',
            },
            {
                '<leader>av',
                function()
                    require('sidekick.cli').send({ msg = '{selection}' })
                end,
                mode = { 'x' },
                desc = 'Send Visual Selection',
            },
            {
                '<leader>ap',
                function() require('sidekick.cli').prompt() end,
                mode = { 'n', 'x' },
                desc = 'Sidekick Select Prompt',
            },
            {
                '<leader>aa',
                function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end,
                desc = 'Sidekick Toggle Claude',
            },
        },
    }
}
