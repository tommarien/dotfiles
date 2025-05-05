vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight String gui=none')
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'jellybeans',
    callback = function()
        vim.cmd('highlight Comment gui=italic')
    end,
})

return {
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false,
        init = function()
            vim.cmd('colorscheme melange')
        end
    },
    {
        'wtfox/jellybeans.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {
            flat_ui = false,
            italics = false,
            transparent = true,
            on_colors = function(c)
                if vim.o.background == 'dark' then
                    c.background = '#1f2329'
                end
            end
        },
        init = function()
            vim.cmd('colorscheme jellybeans')
        end
    }
}
