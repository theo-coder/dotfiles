{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.homeManagerModules.default];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen";
      "$fileManager" = "pcmanfm";
      "$menu" = "~/.local/bin/applauncher";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = lib.mkForce "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkForce "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 7;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow.enabled = false;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      master.new_status = "master";
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = lib.mkForce false;
      };
      input = {
        kb_layout = "us";
        kb_options = "ctrl:nocaps,compose:rctrl";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad.natural_scroll = false;
      };
      gestures.workspace_swipe = true;
      bind =
        [
          "$mod, Return, exec, $terminal"
          "$mod SHIFT, Q, killactive"
          "$mod SHIFT, E, exec, ~/.local/bin/powermenu"
          "$mod SHIFT, Return, exec, $menu"
          "$mod, B, exec, $browser"
          "$mod, SPACE, fullscreen"
          "$mod SHIFT, p, exec, ~/.local/bin/monitor prompt"
          "$mod CONTROL, p, exec, ~/.local/bin/monitor internal"
          "$mod, X, exec, hyprlock"
          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, S, togglespecialworkspace, scratchpad"
          "$mod SHIFT, S, movetoworkspace, special:scratchpad"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, focusworkspaceoncurrentmonitor, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ",Print, exec, ~/.local/bin/capture"
      ];
      windowrule = [
        "suppressevent maximize, class:.*"
        "pin,class:^(rofi)$"
        "float,title:^(Calls Widget)$"
        "noborder,title:^(Calls Widget)$"
        "float,class:Emulator"
      ];
      exec = [
        "~/.local/bin/monitor"
      ];
      exec-once = [
        "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprpolkitagent"

        "poweralertd &"
        "wl-clip-persist --clipboard both &"
        "wl-paste --watch cliphist store &"
        "waybar &"
        "dunst &"
        "hypridle"
      ];
    };
    extraConfig = ''
      xwayland {
          force_zero_scaling = true
      }
    '';
  };
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
