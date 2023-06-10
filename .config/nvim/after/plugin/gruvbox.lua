-- Colors coming from sainnhe version
local diff_colors = {
    dark = {
        bg_diff_green = '#3b4439',
        bg_diff_red = '#472322',
        bg_diff_blue = '#0e363e',
        bg_diff_yellow = '#4d520d'
    },
    light = {
        bg_diff_green = '#dfe1b4',
        bg_diff_red = '#f7d9b9',
        bg_diff_blue = '#e2e6c7',
        bg_diff_yellow = '#ffdb57',
    },
}

function FixGruvbox()
    local vim_bg = vim.o.background
    local colors = require("gruvbox.palette").get_base_colors(vim.o.background, '');

    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = diff_colors[vim_bg].bg_diff_green })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = diff_colors[vim_bg].bg_diff_red })
    vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = diff_colors[vim_bg].bg_diff_red })
    vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = "none", fg = colors.dark2 })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = diff_colors[vim_bg].bg_diff_blue })
    vim.api.nvim_set_hl(0, 'DiffText', { bg = diff_colors[vim_bg].bg_diff_yellow })
end

FixGruvbox()

vim.api.nvim_create_autocmd(
    "ColorScheme",
    { pattern = { "gruvbox" }, callback = FixGruvbox }
)
