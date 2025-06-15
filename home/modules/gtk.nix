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
      package = pkgs.flat-remix-gtk;
    };
  };
}
