local wezterm = require 'wezterm'

return {
    adjust_window_size_when_changing_font_size = false,
    bold_brightens_ansi_colors = true,
    color_scheme = 'Gruvbox dark, medium (base16)',
    font = wezterm.font_with_fallback {
        {
            family = 'MonoLisa',
            harfbuzz_features = {
                '-liga',
                'zero',
                'ss02', -- script variant
                'ss07', -- Alt curly
            },
            weight = 'Medium'
        },
        {
            family = 'Symbols Nerd Font Mono',
            -- scale = 0.75
        }
    },
    font_size = 16,
    force_reverse_video_cursor = true,
    hide_tab_bar_if_only_one_tab = true,
    line_height = 1.06,
    -- macos_window_background_blur = 20,
    scrollback_lines = 5000,
    term = 'wezterm',
    use_cap_height_to_scale_fallback_fonts = true,
    -- window_background_opacity = 0.9,
    window_decorations = 'RESIZE', -- Hide titlebar
    window_padding = {
        left = 20,
        right = 5,
        top = 10,
        bottom = 0
    }
}
