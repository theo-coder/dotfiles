local browser = "zen"
local fileManager = "thunar"
local menu = "~/.local/bin/applauncher"
local mod = "SUPER"
local terminal = "kitty"

hl.curve("myBezier", {
  ["points"] = {
    { 0.05, 0.9 },
    { 0.1, 1.05 }
  },
  ["type"] = "bezier"
})
hl.curve("easeOutQuint", {
  ["points"] = {
    { 0.23, 1 },
    { 0.32, 1 }
  },
  ["type"] = "bezier"
})
hl.curve("quick", {
  ["points"] = {
    { 0.15, 0 },
    { 0.1, 1 }
  },
  ["type"] = "bezier"
})
hl.curve("almostLinear", {
  ["points"] = {
    { 0.5, 0.5 },
    { 0.75, 1 }
  },
  ["type"] = "bezier"
})

hl.animation({
  ["bezier"] = "myBezier",
  ["enabled"] = true,
  ["leaf"] = "windows",
  ["speed"] = 7
})
hl.animation({
  ["bezier"] = "linear",
  ["enabled"] = true,
  ["leaf"] = "windowsOut",
  ["speed"] = 7,
  ["style"] = "popin 80%"
})
hl.animation({
  ["bezier"] = "easeOutQuint",
  ["enabled"] = true,
  ["leaf"] = "border",
  ["speed"] = 10
})
hl.animation({
  ["bezier"] = "easeOutQuint",
  ["enabled"] = true,
  ["leaf"] = "borderangle",
  ["speed"] = 8
})
hl.animation({
  ["bezier"] = "quick",
  ["enabled"] = true,
  ["leaf"] = "fade",
  ["speed"] = 7
})

hl.bind((mod .. " + RETURN"), (hl.dsp.exec_cmd(terminal)))
hl.bind((mod .. " + SHIFT + Q"), (hl.dsp.window.close()), { ["locked"] = true })
hl.bind((mod .. " + SHIFT + E"), (hl.dsp.exec_cmd("~/.local/bin/powermenu")))
hl.bind((mod .. " + SHIFT + RETURN"), (hl.dsp.exec_cmd(menu)))
hl.bind((mod .. " + B"), (hl.dsp.exec_cmd(browser)))
hl.bind((mod .. " + SPACE"), (hl.dsp.window.fullscreen()))
hl.bind((mod .. " + SHIFT + p"), (hl.dsp.exec_cmd("~/.local/bin/monitor prompt")))
hl.bind((mod .. " + CONTROL + p"), (hl.dsp.exec_cmd("~/.local/bin/monitor internal")))
hl.bind((mod .. " + P"), (hl.dsp.exec_cmd("hyprpicker --autocopy")))
hl.bind((mod .. " + C"), (hl.dsp.exec_cmd("~/.local/bin/toggle-center-gaps")))
hl.bind((mod .. " + X"), (hl.dsp.exec_cmd("hyprlock")))
hl.bind((mod .. " + H"), (hl.dsp.focus({ direction = "left" })))
hl.bind((mod .. " + J"), (hl.dsp.focus({ direction = "down" })))
hl.bind((mod .. " + K"), (hl.dsp.focus({ direction = "up" })))
hl.bind((mod .. " + L"), (hl.dsp.focus({ direction = "right" })))
hl.bind((mod .. " + V"), (hl.dsp.exec_cmd("kitty --class clipse -e clipse")))
hl.bind((mod .. " + S"), (hl.dsp.workspace.toggle_special("scratchpad")))
hl.bind((mod .. " + O"), (hl.dsp.exec_cmd("appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --toggle-transcription")))
hl.bind((mod .. " + SHIFT + S"), (hl.dsp.window.move({ workspace = "special:scratchpad" })))
hl.bind((mod .. " + F10"), (hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')")))
hl.bind((mod .. " + F11"), (hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')")))
hl.bind(("XF86AudioRaiseVolume"), (hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")), { ["locked"] = true, ["repeating"] = true })
hl.bind(("XF86AudioLowerVolume"), (hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")), { ["locked"] = true, ["repeating"] = true })
hl.bind(("XF86AudioMute"), (hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")), { ["locked"] = true })
hl.bind(("XF86AudioMicMute"), (hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")), { ["locked"] = true })
hl.bind(("XF86MonBrightnessUp"), (hl.dsp.exec_cmd("brightnessctl set +10%")), { ["locked"] = true, ["repeating"] = true })
hl.bind(("XF86MonBrightnessDown"), (hl.dsp.exec_cmd("brightnessctl set 10%-")), { ["locked"] = true, ["repeating"] = true })
hl.bind(("Print"), (hl.dsp.exec_cmd("~/.local/bin/capture monitor-focused")))
hl.bind(("SHIFT + Print"), (hl.dsp.exec_cmd("~/.local/bin/capture region")))
hl.bind((mod .. " + SHIFT + Print"), (hl.dsp.exec_cmd("~/.local/bin/capture window")))
hl.bind((mod .. " + mouse:272"), (hl.dsp.window.drag()))
hl.bind((mod .. " + mouse:273"), (hl.dsp.window.resize()))

for i = 0, 8 do
  local ws = tostring(i + 1)
  hl.bind((mod .. " + code:1" .. tostring(i)), (hl.dsp.focus({ workspace = ws, on_current_monitor = true })))
  hl.bind((mod .. " + SHIFT + code:1" .. tostring(i)), (hl.dsp.window.move({ workspace = ws })))
end

hl.config({
  ["animations"] = {
    ["enabled"] = true
  },
  ["decoration"] = {
    ["active_opacity"] = 1.0,
    ["blur"] = {
      ["enabled"] = true,
      ["passes"] = 1,
      ["size"] = 3,
      ["vibrancy"] = 0.1696
    },
    ["inactive_opacity"] = 1.0,
    ["rounding"] = 7,
    ["shadow"] = {
      ["color"] = "rgba(1f1f2899)",
      ["enabled"] = false
    }
  },
  ["dwindle"] = {
    ["force_split"] = 2,
    ["preserve_split"] = true
  },
  ["general"] = {
    ["allow_tearing"] = false,
    ["border_size"] = 2,
    ["col"] = {
      ["active_border"] = {
        ["angle"] = 45,
        ["colors"] = {
          "rgba(33ccffee)",
          "rgba(00ff99ee)"
        }
      },
      ["inactive_border"] = "rgba(595959aa)"
    },
    ["col.active_border"] = "rgb(7e9cd8)",
    ["col.inactive_border"] = "rgb(54546d)",
    ["gaps_in"] = 5,
    ["gaps_out"] = 10,
    ["layout"] = "dwindle",
    ["resize_on_border"] = true
  },
  ["group"] = {
    ["col.border_active"] = "rgb(7e9cd8)",
    ["col.border_inactive"] = "rgb(54546d)",
    ["col.border_locked_active"] = "rgb(6a9589)",
    ["groupbar"] = {
      ["col.active"] = "rgb(7e9cd8)",
      ["col.inactive"] = "rgb(54546d)",
      ["text_color"] = "rgb(dcd7ba)"
    }
  },
  ["input"] = {
    ["follow_mouse"] = 1,
    ["kb_layout"] = "us",
    ["kb_options"] = "ctrl:nocaps,compose:rctrl",
    ["sensitivity"] = 0,
    ["touchpad"] = {
      ["natural_scroll"] = false
    }
  },
  ["master"] = {
    ["new_status"] = "master"
  },
  ["misc"] = {
    ["background_color"] = "rgb(1f1f28)",
    ["disable_hyprland_logo"] = true,
    ["force_default_wallpaper"] = 0
  },
  ["xwayland"] = {
    ["force_zero_scaling"] = true
  }
})

hl.on("hyprland.start", function()
  hl.exec_cmd("dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("waybar &")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --start-hidden")
  hl.exec_cmd("~/.local/bin/monitor")
end)

hl.window_rule({
  ["match"] = { ["class"] = ".*" },
  ["name"] = "suppress-maximize",
  ["suppress_event"] = "maximize"
})
hl.window_rule({
  ["match"] = { ["class"] = "^rofi$" },
  ["name"] = "pin-rofi",
  ["pin"] = true
})
hl.window_rule({
  ["border_size"] = 0,
  ["float"] = true,
  ["match"] = { ["title"] = "^Calls Widget$" },
  ["name"] = "calls-widget"
})
hl.window_rule({
  ["float"] = true,
  ["match"] = { ["class"] = "Emulator" },
  ["name"] = "float-emulator"
})
hl.window_rule({
  ["float"] = true,
  ["match"] = { ["title"] = "^Welcome to Android Studio$" },
  ["name"] = "float-android-studio"
})
hl.window_rule({
  ["float"] = true,
  ["match"] = { ["class"] = "clipse" },
  ["name"] = "clipse",
  ["size"] = "800 650"
})
hl.window_rule({
  ["float"] = true,
  ["match"] = { ["title"] = "^Opération sur des fichiers en cours$" },
  ["name"] = "float-file-ops"
})
hl.window_rule({
  ["border_size"] = 0,
  ["match"] = { ["class"] = "Handy" },
  ["name"] = "no-border-handy"
})
