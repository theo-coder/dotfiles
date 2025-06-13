{config, ...}: {
  imports = [
    ./cli.nix
    ./kitty.nix
    ./fish.nix
    ./nvim.nix
    ./starship.nix
  ];

  home = rec {
    username = "theo";
    homeDirectory = "/home/${username}";
    file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "../config/bin";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
