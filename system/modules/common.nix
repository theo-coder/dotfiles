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
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./stylix.nix
    ./users.nix
    ./ectool.nix
    ./wayland.nix
    ./ia.nix
  ];

  services.dbus.enable = true;
}
