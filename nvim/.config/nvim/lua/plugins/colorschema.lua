return {
    {
        dir = '~/.config/nvim/lua/github-dark-plus',
        lazy = false,
        priority = 1000,
        init = function()
            vim.cmd('colorscheme github-dark-plus')
        end
    }
}
