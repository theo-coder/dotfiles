import os
import subprocess

from libqtile import hook, layout, bar
from libqtile.lazy import lazy
from libqtile.config import Key, Group, Match, Drag, Click, Screen

from color_theme import colors
import widgets as widgets

wmname = "LG3D"
mod = "mod4"
myTerm = "alacritty"
myBrowser = "brave"
colors = colors

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None

keys = [
    # essentials
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload config"),
    # windows
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill current window"),
    Key([mod], "space", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "shift"], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    # programs
    Key([mod], "return", lazy.spawn(myTerm), desc="Launch terminal"),
    Key([mod], "f", lazy.spawn(myTerm), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn(myBrowser), desc="Launch browser"),
    Key(
        [mod, "shift"], "e", lazy.spawn("/home/theo/.local/bin/powermenu"), desc="Launch powermenu"
    ),
    Key(
        [mod, "shift"],
        "return",
        lazy.spawn("/home/theo/.local/bin/applauncher"),
        desc="Run AppLauncher",
    ),
    Key([mod], "r", lazy.spawncmd(), desc="Run prompt widget"),
    # navigation
    Key([mod], "k", lazy.layout.next(), desc="Focus next window"),
    Key([mod], "j", lazy.layout.previous(), desc="Focus previous window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Swap focused with left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Swap focused with down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Swap focused with up"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Swap focused with right"),
    # media
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "amixer sset Master 5%-"), desc="Lower volume"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "amixer sset Master 5%+"), desc="Raise volume"),
    Key([], "XF86AudioMute", lazy.spawn(
        "amixer sset Master 1+ toggle"), desc="Toggle mute"),
    Key([], "XF86AudioPlay", lazy.spawn(
        "playerctl play-pause"), desc="Toggle play/pause"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next media"),
    Key([], "XF86AudioPrev", lazy.spawn(
        "playerctl previous"), desc="Previous media"),
]

groups = []  # type: list[Group]
group_names = [
    "ampersand",
    "eacute",
    "quotedbl",
    "apostrophe",
    "parenleft",
    "minus",
    "egrave",
    "underscore",
    "ccedilla",
]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

for i in range(len(group_names)):
    groups.append(
        Group(name=group_names[i], layout="monadtall", label=group_labels[i]))

for group in groups:
    keys.extend(
        [
            Key(
                [mod],
                group.name,
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.label),
            ),
            Key(
                [mod, "shift"],
                group.name,
                lazy.window.togroup(group.name, switch_group=False),
                desc="Move focused window to group {}".format(group.label),
            ),
        ]
    )

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": colors["light_blue"],
    "border_normal": colors["dark_grey"],
}

layouts = [layout.MonadTall(**layout_theme),
           layout.Max(border_width=0, margin=0)]
floating_layout = layout.Floating(
    border_focus=colors["light_blue"],
    border_width=2,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="notification"),
        Match(wm_class="pinentry-gtk-2"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="toolbar"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
        Match(title="Qalculate!"),
    ],
)

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

widget_defaults = dict(font="Ubuntu Bold", fontsize=24,
                       padding=0, background=colors["dark_grey"])

extension_defaults = widget_defaults.copy()


def init_widgets_list():
    return [
        widgets.logo,
        widgets.workspaces,
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
        widgets.spacer,
    ]


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[15:16]
    return widgets_screen2


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=48, **widget_defaults)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=48, **widget_defaults))]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()


@hook.subscribe.client_new
def assign_app_group(client):
    wm_class_default_group = {
        "discord": group_names[5],
        "obsidian": group_names[4],
        "xterm": group_names[8],
    }

    wm_name_default_group = {"brave": group_names[1]}

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
