return {
    {
        'Mofiqul/vscode.nvim',
        priority = 1000,
        enabled = not vim.g.vscode,
        lazy = false,
        opts = {
            transparent = true,
            italic_comments = true,
            group_overrides = {
                CursorLine = { bg = "#303030" }
            }
        },
        init = function()
            vim.cmd('colorscheme vscode')
        end
    },
}
