{
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    flat-remix-gtk
  ];

  gtk = {
    enable = true;
    theme.name = lib.mkForce "Flat-Remix-GTK-Orange-Darkest-Solid";
  };
}
