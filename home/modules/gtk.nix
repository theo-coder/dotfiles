{
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = lib.mkForce "Flat-Remix-GTK-Orange-Darkest-Solid";
      package = lib.mkForce pkgs.flat-remix-gtk;
    };
    iconTheme = {
      name = lib.mkForce "Papirus-Dark";
      package = lib.mkForce pkgs.papirus-icon-theme;
    };
  };
}
