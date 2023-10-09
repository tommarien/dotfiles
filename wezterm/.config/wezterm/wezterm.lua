local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size = false,
    color_scheme = 'duskfox',
    font = wezterm.font_with_fallback {
        {
            family = 'MonoLisa',
            harfbuzz_features = { 'ss02' }
        },
        {
            family = 'Symbols Nerd Font Mono',
            scale = 0.75
        }
    },
    font_size = 16,
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 5000,
    use_cap_height_to_scale_fallback_fonts = true,
    window_background_opacity = 0.87,
    window_decorations = "RESIZE", -- Hide titlebar
    window_padding = {
        left = 20,
        right = 5,
        top = 10,
        bottom = 0
    }
}
