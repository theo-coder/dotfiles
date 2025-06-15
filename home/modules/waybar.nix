{...}: {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 16;
      modules-left = [
        "image#nix-ico"
        "hyprland/workspaces"
        "custom/arrow"
        "hyprland/window"
      ];
      "image#nix-ico" = {
        path = "~/.local/assets/nix.png";
        size = 16;
      };
      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          urgent = "";
          focused = "";
          default = "";
        };
        all-outputs = true;
        sort-by-number = true;
        persistent-workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
          "9" = [];
        };
      };
      "custom/arrow" = {
        format = ">";
      };
      "hyprland/window" = {
        format = "{}";
        separate-outputs = true;
      };
    };
  };
}
