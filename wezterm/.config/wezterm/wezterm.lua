local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size = false,
    color_scheme = 'duskfox',
    font = wezterm.font {
        family = 'MonoLisa',
        harfbuzz_features = { 'ss02' }
    },
    font_size = 15.0,
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.8,
    macos_window_background_blur = 10,
    window_padding = {
        left = '0.5cell',
        right = '0.5cell',
        top = 0,
        bottom = 0
    }
}
