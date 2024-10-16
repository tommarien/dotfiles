return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            -- Set gruvbox material settings
            vim.g.gruvbox_material_foreground = 'original'
            vim.g.gruvbox_material_statusline_style = 'original'
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 'highlighted'
            vim.g.gruvbox_material_ui_contrast = 'high'

            -- Apply the colorscheme
            -- vim.cmd [[colorscheme gruvbox-material]]
            --
            -- -- Override WhichKeySeparator, otherwise would be displayed as italic
            -- local hl_cmt = vim.api.nvim_get_hl_by_name("Comment", true)
            -- local hl_sep = vim.tbl_extend("force", hl_cmt, { italic = false })
            -- vim.api.nvim_set_hl(0, 'WhichKeySeparator', hl_sep)
        end
    },
    {
        'sainnhe/everforest',
        lazy = false,
        config = function()
            vim.g.everforest_better_performance = 1
            vim.g.everforest_diagnostic_virtual_text = 1
        end
    },
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none'
                        }
                    }
                },
            },
            overrides = function()
                return { ['@lsp.mod.readonly'] = { link = '@lsp' }, }
            end,
            keywordStyle = { italic = false },
            transparent = false,
        },
        config = function(_, opts)
            require('kanagawa').setup(opts)
            vim.cmd('colorscheme kanagawa')
        end,
    }
}
