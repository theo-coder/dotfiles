import subprocess

from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

from color_theme import colors

logo = widget.Image(
    filename="~/.config/qtile/icons/arch.png",
    scale="False",
    mouse_callbacks={"Button1": lazy.spawn("alacritty")},
    margin_x=10,
    margin_y=5,
)

prompt = widget.Prompt(font="Ubuntu Mono", fontsize=28, foreground=colors["light_grey"])

workspaces = widget.GroupBox(
    fontsize=26,
    margin_y=6,
    margin_x=0,
    padding_y=5,
    padding_x=6,
    borderwidth=6,
    active=colors["light_blue"],
    inactive=colors["light_grey"],
    rounded=False,
    highlight_color=colors["black"],
    highlight_method="line",
    this_current_screen_border=colors["pink"],
    this_screen_border=colors["green"],
    other_current_screen_border=colors["pink"],
    other_screen_border=colors["green"],
)


separator = widget.TextBox(
    text="|", font="Ubuntu Mono", foreground=colors["light_grey"], padding=2, fontsize=34
)

current_layout = [
    widget.CurrentLayoutIcon(foreground=colors["light_grey"], padding=0, scale=0.7),
    widget.CurrentLayout(foreground=colors["light_grey"], padding=5),
]

window_name = widget.WindowName(foreground=colors["blue"], max_chars=40)

spacer = widget.Spacer(length=16)

cpu = widget.CPU(
    format="   Cpu: {load_percent}%",
    mouse_callbacks={"Button1": lazy.spawn("alacritty" + " -e htop")},
    foreground=colors["yellow"],
    decorations=[
        BorderDecoration(
            colour=colors["yellow"],
            border_width=[0, 0, 2, 0],
        )
    ],
)

memory = widget.Memory(
    foreground=colors["red"],
    mouse_callbacks={"Button1": lazy.spawn("alacritty" + " -e htop")},
    format="{MemUsed: .0f}{mm}",
    fmt="🖥  Mem: {}",
    decorations=[
        BorderDecoration(
            colour=colors["red"],
            border_width=[0, 0, 2, 0],
        )
    ],
)

updates = widget.GenPollText(
    update_interval=300,
    mouse_callbacks={"Button1": lazy.spawn("alacritty" + " -e sudo pacman -Syu")},
    func=lambda: subprocess.check_output('printf "$(pacupdate)"', shell=True, text=True),
    foreground=colors["pink"],
    decorations=[
        BorderDecoration(
            colour=colors["pink"],
            border_width=[0, 0, 2, 0],
        )
    ],
    fmt="󰂚  {}",
)

battery = widget.Battery(
    foreground=colors["orange"],
    charge_char="",
    discharge_char="",
    empty_char="",
    format="{char}    {percent:2.0%}",
    low_foreground=colors["red"],
    low_percentage=0.1,
    decorations=[BorderDecoration(colour=colors["orange"], border_width=[0, 0, 2, 0])],
)

clock = widget.Clock(
    foreground=colors["light_blue"],
    format="  %a, %b %d - %H:%M",
    decorations=[
        BorderDecoration(
            colour=colors["light_blue"],
            border_width=[0, 0, 2, 0],
        )
    ],
)

systray = widget.Systray(padding=3, icon_size=40)
