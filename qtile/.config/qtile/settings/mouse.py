from libqtile.command import lazy
from libqtile.config import Drag

from .keys import META


def init_mouse():
    return [
        Drag([META], "Button1", lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([META], "Button3", lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
    ]
