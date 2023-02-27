local wezterm = require 'wezterm';
local rosePine = require 'lua/rose-pine-moon';

return {
    adjust_window_size_when_changing_font_size = false,
    colors = rosePine.colors(),
    hide_tab_bar_if_only_one_tab = true,
    font = wezterm.font {
        family = 'MonoLisa',
        harfbuzz_features = { 'ss02' },
    },
    font_size = 15.0,
    window_frame = rosePine.window_frame(),
    keys = {
        {
            key = 'k',
            mods = 'SUPER',
            action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
        },
    },
}
