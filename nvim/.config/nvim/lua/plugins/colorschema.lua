return {
    {
        dir = '~/.config/nvim/lua/github_dark_plus',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd('colorscheme github_dark_plus')
        end
    },
}
