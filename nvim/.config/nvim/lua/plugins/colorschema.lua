return {
    {
        'shatur/neovim-ayu',
        lazy = false,
        priority = 1000,
        opts = {
            mirage = true,
            overrides = {
                Normal = { bg = 'None' },
                ColorColumn = { bg = 'None' },
                SignColumn = { bg = 'None' },
                Folded = { bg = 'None' },
                FoldColumn = { bg = 'None' },
                CursorLine = { bg = 'None' },
                CursorColumn = { bg = 'None' },
                VertSplit = { bg = 'None' },
            }
        },
        config = function(_, opts)
            require('ayu').setup(opts)
            vim.cmd('colorscheme ayu')
        end
    }
}
