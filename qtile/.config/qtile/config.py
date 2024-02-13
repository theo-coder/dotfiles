import os
import subprocess

from libqtile import hook

from settings.color_theme import colors
from settings.groups import init_groups, group_names
from settings.keys import init_keybindings
from settings.layouts import init_layouts, init_floating_layout
from settings.screens import init_screens
from settings.bars import bar_defaults
from settings.mouse import init_mouse

wmname = "LG3D"
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
auto_minimize = False

colors = colors
layouts = init_layouts()
floating_layout = init_floating_layout()
groups = init_groups()
keys = init_keybindings(groups=groups)
mouse = init_mouse()
widget_defaults = bar_defaults.copy()
screens = init_screens()

main = None


@hook.subscribe.client_new
def assign_app_group(client):
    wm_class_default_group = {
        "discord": group_names[5],
        "notion": group_names[7],
        "obsidian": group_names[4],
        "xterm": group_names[8]
    }

    wm_name_default_group = {
        "brave": group_names[1]
    }

    wm_class = client.get_wm_class()
    wm_class = wm_class[0].lower() if len(wm_class) else ""

    if wm_class in wm_class_default_group:
        client.togroup(wm_class_default_group[wm_class])

    wm_name = client.name.lower()
    if wm_name in wm_name_default_group:
        client.togroup(wm_name_default_group[wm_name])


@hook.subscribe.startup_once
def start_once():
    subprocess.call(os.path.expanduser("~/.config/qtile/autostart.sh"))
