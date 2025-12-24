return {
    {
        'tommarien/github-plus.nvim',
        -- dir = '~/Projects/tommarien/github-plus.nvim',
        lazy = false,
        priority = 1000,
        version = false,
        --- @type GithubPlus.Overrides
        opts = {
            semantic = true,
            transparent = true,
        },
        config = function(_, opts)
            require('github_plus').setup(opts)
            vim.cmd('colorscheme github_plus')
        end
    },
    { 'projekt0n/github-nvim-theme', name = 'github-theme' }
}
