from libqtile import bar

from . import widgets
from .color_theme import colors

bar_defaults = dict(
    font="Ubuntu Bold",
    fontsize=24,
    padding=0,
    background=colors["dark_grey"],
    size=48,
)


def init_main_bar():
    widgets_list = [
        widgets.logo,
        widgets.prompt,
        widgets.workspaces,
        widgets.separator,
        *widgets.current_layout,
        widgets.separator,
        widgets.window_name,
        widgets.spacer,
        widgets.cpu,
        widgets.spacer,
        widgets.memory,
        widgets.spacer,
        widgets.updates,
        widgets.spacer,
        widgets.battery,
        widgets.spacer,
        widgets.clock,
        widgets.spacer,
        widgets.systray,
        widgets.spacer
    ]

    return bar.Bar(widgets=widgets_list, **bar_defaults)


def init_secondary_bar():
    widgets_list = [
        widgets.logo,
        widgets.prompt,
        widgets.workspaces,
        widgets.separator,
        *widgets.current_layout,
        widgets.separator,
        widgets.window_name,
        widgets.spacer,
        widgets.cpu,
        widgets.spacer,
        widgets.memory,
        widgets.spacer,
        widgets.updates,
        widgets.spacer,
        widgets.battery,
        widgets.spacer,
        widgets.clock,
        widgets.spacer
    ]

    return bar.Bar(widgets=widgets_list, **bar_defaults)
