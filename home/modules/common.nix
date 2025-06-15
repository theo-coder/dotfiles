{config, ...}: {
  imports = [
    ./cli.nix
    ./kitty.nix
    ./fish.nix
    ./nvim.nix
    ./starship.nix
    ./hyprland.nix
  ];

  home = rec {
    username = "theo";
    homeDirectory = "/home/${username}";
    file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink ../config/bin;
    file.".local/lib".source = config.lib.file.mkOutOfStoreSymlink ../config/lib;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
