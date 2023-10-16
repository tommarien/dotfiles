local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size = false,
    bold_brightens_ansi_colors = 'No',
    color_scheme = 'duskfox',
    -- Kanagawa
    -- colors = {
    --     foreground = "#dcd7ba",
    --     background = "#1f1f28",
    --
    --     cursor_bg = "#c8c093",
    --     cursor_fg = "#c8c093",
    --     cursor_border = "#c8c093",
    --
    --     selection_fg = "#c8c093",
    --     selection_bg = "#2d4f67",
    --
    --     scrollbar_thumb = "#16161d",
    --     split = "#16161d",
    --
    --     ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    --     brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    --     indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    -- },
    font = wezterm.font_with_fallback {
        {
            family = 'JetBrains Mono',
        },
        -- {
        --     family = 'Iosevka Term',
        --     stretch = 'Expanded',
        --     harfbuzz_features = { 'ss14', 'calt=0' },
        -- },
        -- {
        --     family = 'MonoLisa',
        --     harfbuzz_features = { 'ss01' },
        -- },
        {
            family = 'Symbols Nerd Font Mono',
            -- scale = 0.75
        }
    },
    font_size = 16,
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 5000,
    use_cap_height_to_scale_fallback_fonts = true,
    window_background_opacity = 0.9,
    window_decorations = 'RESIZE', -- Hide titlebar
    window_padding = {
        left = 20,
        right = 5,
        top = 10,
        bottom = 0
    }
}
