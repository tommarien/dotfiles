-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Set filetype to jsonc for some files
local jsonFileTypeDetect = vim.api.nvim_create_augroup('jsonFtDetect', { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "tsconfig*.json", ".eslintrc.json" },
    group = jsonFileTypeDetect,
    callback = function(ev)
        vim.api.nvim_buf_call(ev.buf, function()
            vim.api.nvim_cmd({ cmd = 'setf', args = { 'jsonc' } }, {})
        end)
    end,
})

-- Enable crates.nvim only on cargo.toml
local cargoGroup = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
    group = cargoGroup,
    pattern = "Cargo.toml",
    callback = function()
        require("cmp").setup.buffer({ sources = { { name = "crates" } } })
    end,
})

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

    vim.api.nvim_set_hl(0, 'PackageInfoUpTodateVersion', { fg = colors.green })
    vim.api.nvim_set_hl(0, 'PackageInfoOutdatedVersion', { fg = colors.red })
end

local colorSchemeGroup = vim.api.nvim_create_augroup('colorSchemeGroup', { clear = true })

vim.api.nvim_create_autocmd(
    "ColorScheme",
    {
        group = colorSchemeGroup,
        pattern = { "gruvbox" },
        callback = function()
            FixGruvbox()
        end
    }
)
