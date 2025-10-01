vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'melange',
    callback = function()
        vim.cmd('highlight Normal guibg=none')
        vim.cmd('highlight ColorColumn guibg=#282826')
        vim.cmd('highlight Comment guifg=#9d8b78')
        vim.cmd('highlight GitSignsCurrentLineBlame guifg=#7d6b58')
        vim.cmd('highlight LspReferenceText guibg=#383128 gui=none')
        vim.cmd('highlight MatchParen guibg=#413a30')
        vim.cmd('highlight NormalFloat guibg=none')
        vim.cmd('highlight Spellbad guifg=none guisp=#bd8183')
        vim.cmd('highlight String gui=none')

        vim.api.nvim_set_hl(0, 'FloatBorder', {
            fg = '#7d6b58',
            bg = 'NONE'
        })

        vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {
            fg = '#a89984', -- Dimmed color from melange palette
            italic = true,
            undercurl = true,
            sp = '#928374' -- Subtle underline
        })
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'onedark',
    callback = function()
        vim.api.nvim_set_hl(0, 'QuickFixLine', { link = 'CursorLine' })
    end,
})

return {
    {
        'savq/melange-nvim',
        priority = 1000,
        lazy = false
    },
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                    styles = {
                        comments = 'italic'
                    }
                },
                groups = {
                    terafox = {
                        CursorLine = { bg = '#1a2428' }
                    }
                }
            })
            -- vim.cmd('colorscheme terafox')
        end
    },
    {
        'Mofiqul/vscode.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            transparent = true,
            italic_comments = true,
            group_overrides = {
                CursorLine = { bg = "#252525" }
            }
        },
        init = function()
            vim.cmd('colorscheme vscode')
        end
    },
}
