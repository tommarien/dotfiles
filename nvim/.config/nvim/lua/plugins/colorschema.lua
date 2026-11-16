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
            transparent = true,
            italic_comments = true,
            group_overrides = {
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
        },
        config = function(_, opts)
            require('vscode').setup(opts)
            vim.cmd('colorscheme vscode')
        end
    },
}
