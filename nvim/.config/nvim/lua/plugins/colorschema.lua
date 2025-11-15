return {
    {
        'tommarien/github-plus.nvim',
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
