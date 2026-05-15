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
                    split = {
                        size = 0.3, -- size of the split (0-1 for percentage)
                    },
                },
            },
        },
        keys = {
            {
                '<leader>sc',
                function() require('sidekick.cli').select() end,
                -- Or to select only installed tools:
                -- require('sidekick.cli').select({ filter = { installed = true } })
                desc = 'Select CLI',
            },
            {
                '<leader>sd',
                function() require('sidekick.cli').close() end,
                desc = 'Detach a CLI Session',
            },
            {
                '<leader>st',
                function() require('sidekick.cli').send({ msg = '{this}' }) end,
                mode = { 'x', 'n' },
                desc = 'Send This',
            },
            {
                '<leader>sf',
                function() require('sidekick.cli').send({ msg = '{file}' }) end,
                desc = 'Send File',
            },
            {
                '<leader>sv',
                function() require('sidekick.cli').send({ msg = '{selection}' }) end,
                mode = { 'x' },
                desc = 'Send Visual Selection',
            },
            {
                '<leader>sp',
                function() require('sidekick.cli').prompt() end,
                mode = { 'n', 'x' },
                desc = 'Sidekick Select Prompt',
            },
            {
                '<leader>st',
                function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end,
                desc = 'Sidekick Toggle Claude',
            },
        },
    }
}
