return {
    {
        dir = '~/.config/nvim/lua/github_plus',
        lazy = false,
        priority = 1000,
        --- @type GithubPlus.Overrides
        opts = {
            transparent = true,
        },
        config = function(_, opts)
            require('github_plus').setup(opts)
            vim.cmd('colorscheme github_plus')
        end
    },
}
