return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                variant = 'auto',      -- auto, main, moon, or dawn
                dark_variant = 'moon', -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
                    migrations = true,         -- Handle deprecated options automatically
                },

                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },

                palette = {
                    --Override the builtin palette per variant
                    moon = {
                        base = '#1c1c1e',
                    },
                },

                -- NOTE: Highlight groups are extended (merged) by default. Disable this
                -- per group via `inherit = false`
                highlight_groups = {
                    Comment = { italic = true },
                    DiffviewNormal = { bg = 'NONE' }
                },
            })
            vim.cmd('colorscheme rose-pine')
        end
    },
}
