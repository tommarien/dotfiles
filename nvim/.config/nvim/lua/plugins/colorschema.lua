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
            -- require('github_plus').setup(opts)
            -- vim.cmd('colorscheme github_plus')
        end
    },
    {
        'Mofiqul/vscode.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            italic_comments = true,
        },
        config = function(_, opts)
            local dark_overrides = {
                -- Normal = { bg = "NONE" },
                CursorLine = { bg = "#303030" },
                SnacksPickerListCursorLine = { bg = "#1e3a54" },
                Visual = { bg = "#1e3a54" },
                Comment = { fg = "#859289", italic = true },
                ['@comment'] = { fg = "#859289", italic = true },
                DiffAdd = { bg = "#34402a", fg = "NONE", bold = false },
                DiffDelete = { bg = "#4A2323", fg = "NONE", bold = false },
                DiffChange = { bg = "#34402a", fg = "NONE", bold = false },
                DiffText = { bg = "#44658A", fg = "NONE", bold = false },
            }

            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'vscode',
                group = vim.api.nvim_create_augroup('vscode_dark_overrides', { clear = true }),
                callback = function()
                    if vim.o.background ~= 'dark' then return end
                    for name, spec in pairs(dark_overrides) do
                        local current = vim.api.nvim_get_hl(0, { name = name, link = false })
                        vim.api.nvim_set_hl(0, name, vim.tbl_extend('force', current, spec))
                    end
                end,
            })

            -- require('vscode').setup(opts)
            -- vim.cmd('colorscheme vscode')
        end
    },
    {
        "savq/melange-nvim",
        config = function()
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'melange',
                group = vim.api.nvim_create_augroup('melange_dark_overrides', { clear = true }),
                callback = function()
                    vim.cmd('highlight String gui=none')
                    if vim.o.background ~= 'dark' then return end
                    vim.cmd('highlight SnacksIndent guifg=#3a3734')
                    vim.cmd('highlight SnacksIndentScope guifg=#8a7d73')
                    vim.cmd("highlight Normal guibg='none'")
                    vim.cmd("highlight Float guibg='none'")
                    vim.cmd("highlight NormalFloat guibg='none'")
                    vim.cmd("highlight FloatBorder guibg='none'")
                    vim.cmd("highlight FloatTitle guibg='none'")
                end,
            })
            vim.cmd('colorscheme melange')
        end
    }
}
