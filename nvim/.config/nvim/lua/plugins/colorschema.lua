return {
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_foreground = 'original'
            -- vim.g.gruvbox_material_background = 'soft'
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = 1
            vim.cmd('colorscheme gruvbox-material')

            -- Override WhichKeySeparator, otherwise would be displayed as italic
            local hl_cmt = vim.api.nvim_get_hl_by_name("Comment", true)
            local hl_sep = vim.tbl_extend("force", hl_cmt, { italic = false })
            return vim.api.nvim_set_hl(0, "WhichKeySeparator", hl_sep)
        end
    },
}
