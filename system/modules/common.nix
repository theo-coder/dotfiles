{...}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./browser.nix
    ./coding.nix
    ./fonts.nix
    ./keyboard.wayland.nix
    ./linux.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./packages.wayland.nix
    # ./picom.nix
    ./shell.nix
    ./sound.nix
    ./stylix.nix
    ./users.nix
    ./ectool.nix
    ./wayland.nix
    ./ia.nix
    ./docker.nix
    ./tmux.nix
    ./games.nix
    ./security.nix
  ];

  services.dbus.enable = true;
  services.upower.enable = true;
}
