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
  ];

  home = rec {
    username = "theo";
    homeDirectory = "/home/${username}";
    file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../config/bin;
    file.".local/lib".source = config.lib.file.mkOutOfStoreSymlink ../config/lib;
    file.".local/assets".source = config.lib.file.mkOutOfStoreSymlink ../../assets;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
