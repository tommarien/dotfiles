return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                keywords = { italic = false },
                -- Background styles. Can be 'dark', 'transparent' or 'normal'
                sidebars = 'normal', -- style for sidebars, see below
                floats = 'normal',   -- style for floating windows
            }
        },
        init = function()
            vim.cmd('colorscheme tokyonight-night')
        end
    }
}
