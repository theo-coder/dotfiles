from libqtile import layout
from libqtile.config import Match

from .color_theme import colors


def layout_defaults(**kwargs: dict):
    return {
        "margin": kwargs.get("margin", 8),
        "border_width": kwargs.get("border_width", 2),
        "border_focus": kwargs.get("border_focus", colors["light_blue"]),
        "border_normal": kwargs.get("border_normal", colors["dark_grey"])
    }


def init_layouts():
    return [
        layout.MonadTall(**layout_defaults()),
        layout.Max(border_width=0, margin=0)
    ]


def init_floating_layout():
    float_rules = [
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="obsidian"),
        Match(wm_class="svelte-tauri"),
    ]

    return layout.Floating(
        float_rules=float_rules,
        fullscreen_border_width=0,
        **layout_defaults()
    )
