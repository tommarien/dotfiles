from kitty.boss import get_boss
from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_tab_with_powerline


ATTENTION = (0xF2CC60 << 8) | 2


def other_sessions() -> dict[str, bool]:
    boss = get_boss()
    current = {w.created_in_session_name for w in boss.active_tab.windows}
    sessions: dict[str, bool] = {}
    for tab in boss.all_tabs:
        for w in tab.windows:
            name = w.created_in_session_name
            if name and name not in current:
                sessions[name] = sessions.get(name, False) or bool(w.needs_attention)
    return sessions


def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData,
) -> int:
    end = draw_tab_with_powerline(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)
    if is_last:
        if any(other_sessions().values()):
            screen.cursor.fg = ATTENTION
            screen.draw(" ●")
            end = screen.cursor.x
    return end
