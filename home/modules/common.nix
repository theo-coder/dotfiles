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
    ./git.nix
  ];

  home = rec {
    username = "theo";
    homeDirectory = "/home/${username}";
    file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../config/bin;
    file.".local/lib".source = config.lib.file.mkOutOfStoreSymlink ../config/lib;
    file.".config/electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
    file.".config/wpaperd/config.toml".text = ''
      [default]
      mode = "center"
      path = "/home/theo/Images/wallpapers/landscape/"
    '';
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
