{...}: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./browser.nix
    ./coding.nix
    ./fonts.nix
    ./keyboard.nix
    ./linux.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./packages.nix
    ./picom.nix
    ./python.nix
    ./shell.nix
    ./sound.nix
    ./stylix.nix
    ./xmonad.nix
    ./users.nix
    ./ectool.nix
  ];

  services.dbus.enable = true;
}
