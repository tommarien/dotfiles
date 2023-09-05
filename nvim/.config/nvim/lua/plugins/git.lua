return {
    {
        'NeogitOrg/neogit',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = 'Neogit',
        opts = {
            integrations = {
                diffview = true,
            }
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        version = '*',
        opts = {},
    },
    {
        'sindrets/diffview.nvim',
        event = 'VeryLazy',
        dependencies = 'nvim-lua/plenary.nvim',
        opts = {
            use_icons = true,
            enhanced_diff_hl = true,
            keymaps = {
                file_panel = {
                    ['q'] = "<Cmd>DiffviewClose<CR>",
                },
            }
        }
    },
}
