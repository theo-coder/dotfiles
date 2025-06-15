{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "zen-browser";
      "$menu" = "~/.local/bin/applauncher";
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
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };
}
