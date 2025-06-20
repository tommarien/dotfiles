vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight CursorLine guibg=none')
        vim.cmd('highlight SnacksIndent guifg=#3a3734')
        vim.cmd('highlight SnacksIndentScope guifg=#8a7d73')
        vim.cmd('highlight String gui=none')
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'sonokai',
    callback = function()
        vim.cmd('highlight CursorLine guibg=none')
        vim.cmd('highlight SnacksIndentScope guifg=#6C64A0')
        vim.cmd('highlight SnacksPickerCursorLine guibg=#394634')
        vim.cmd('highlight SnacksPickerListCursorLine guibg=#394634')
        vim.api.nvim_set_hl(0, 'PackageInfoUpTodateVersion', { link = 'Added' })
        vim.api.nvim_set_hl(0, 'PackageInfoOutdatedVersion', { link = 'Removed' })
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'rose-pine-moon',
    callback = function()
        vim.cmd('highlight CursorLine guibg=none')
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
        'sainnhe/sonokai',
        priority = 1000,
        lazy = false,
        init = function()
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_style = 'shusia'
            vim.g.sonokai_transparent_background = 1
        end
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        priority = 1000,
        lazy = false,
        opts = {
            styles = {
                italic = false,
                transparency = true,
            },
        },
    }
}
