return {
    {
        'tommarien/github-plus.nvim',
        -- dir = '~/Projects/tommarien/github-plus.nvim/main',
        lazy = false,
        priority = 1000,
        version = false,
        --- @type GithubPlus.Overrides
        opts = {
            styles = {
                comments = { italic = true },
            },
            transparent = { dark = true },
        },
        config = function(_, opts)
            require('github_plus').setup(opts)
            vim.cmd('colorscheme github_plus')
            vim.api.nvim_set_hl(0, 'SidekickChat', { link = 'Normal' })
        end
    }
}
