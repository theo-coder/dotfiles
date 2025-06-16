{config, ...}: {
  imports = [
    ./cli.nix
    ./kitty.nix
    ./fish.nix
    ./nvim.nix
    ./starship.nix
    ./hyprland.nix
    ./gtk.nix
    ./waybar.nix
    ./applications.nix
  ];

  home = rec {
    username = "theo";
    homeDirectory = "/home/${username}";
    file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../config/bin;
    file.".local/lib".source = config.lib.file.mkOutOfStoreSymlink ../config/lib;
    file.".local/assets".source = config.lib.file.mkOutOfStoreSymlink ../../assets;
    file.".config/electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = "zen.desktop";
      "text/html" = "zen.desktop";
      "text/xml" = "zen.desktop";
      "x-scheme-handler/ftp" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
    };
  };
}
