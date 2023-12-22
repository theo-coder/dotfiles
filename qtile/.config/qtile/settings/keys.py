import os

from libqtile.config import Key
from libqtile.command import lazy

import utils

META = "mod4"
SHIFT = "shift"
CTRL = "control"
RETURN = "Return"
SPACE = "space"

HOME = os.path.expanduser("~")

TERM = "alacritty"
BROWSER = "brave"


def init_keybindings(groups):
    essentials = [
        # Reload the config
        Key([META, SHIFT], "r", lazy.reload_config()),
        # Restart qtile
        Key([META, CTRL], "r", lazy.restart()),
    ]

    # scratchpads = [
    #     Key([META, CTRL], RETURN,
    #         lazy.group["terminal"].dropdown_toggle('term')),
    # ]

    windows = [
        # Kill focused window
        Key([META, SHIFT], "q", lazy.window.kill()),
        # Kill all windows
        Key([META, SHIFT], "a", utils.kill_all_windows()),
        # Toggle fullscreen
        Key([META], SPACE, lazy.window.toggle_fullscreen()),
        # Toggle floating
        Key([META, SHIFT], "t", lazy.window.toggle_floating()),
    ]

    programs = [
        # Launch terminal
        Key([META], RETURN, lazy.spawn(TERM)),
        # Launch browser
        Key([META], "b", lazy.spawn(BROWSER)),
        # Show power menu
        Key([META, SHIFT], "e", lazy.spawn("/home/theo/.local/bin/powermenu")),
        # Run launcher
        Key([META, SHIFT], RETURN, lazy.spawn(
            "/home/theo/.local/bin/applauncher")),
        # Run promp widget
        Key([META], "r", lazy.spawncmd())
    ]

    navigation = [
        # Focus next window
        Key([META], "k", lazy.layout.next()),
        # Focus previous window
        Key([META], "j", lazy.layout.previous()),
        # Swap focused window with left
        Key([META, SHIFT], "h", lazy.layout.shuffle_left()),
        # Swap focused window with down
        Key([META, SHIFT], "j", lazy.layout.shuffle_down()),
        # Swap focused window with up
        Key([META, SHIFT], "k", lazy.layout.shuffle_up()),
        # Swap focused window with right
        Key([META, SHIFT], "l", lazy.layout.shuffle_right())
    ]

    medias = [
        # Lower volume by 5%
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-")),
        # Raise volume by 5%
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+")),
        # Mute/Unmute audio
        Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle")),
        # Play/Pause player
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        # Skip to next
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        # Skip to previous
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    ]

    for i in groups:
        navigation.extend(
            [
                # Switch to group
                Key([META], i.name, lazy.group[i.name].toscreen()),
                # Send focused window to group
                Key([META, SHIFT], i.name, lazy.window.togroup(i.name)),
            ]
        )

    return essentials + windows + programs + navigation + medias  # + scratchpads
