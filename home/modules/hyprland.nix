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
          ", Print, exec, grimblast copy area"
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
    };
  };
}
