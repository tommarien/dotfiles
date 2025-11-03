return {
    {
        dir = '~/.config/nvim/lua/github_dark_min',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd('colorscheme github_dark_min')
        end
    },
}
