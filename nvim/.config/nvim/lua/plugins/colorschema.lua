return {
    {
        dir = '~/.config/nvim/lua/github_dark_min',
        lazy = false,
        priority = 1000,
        --- @type GithubDarkMin.Overrides
        opts = {
            transparent = true,
        },
        config = function(_, opts)
            require('github_dark_min').setup(opts)
            vim.cmd('colorscheme github_dark_min')
        end
    },
}
