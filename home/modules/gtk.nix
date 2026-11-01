{
  pkgs,
  lib,
  ...
}:
{
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    # gtk4.theme = {
    #   name = "Flat-Remix-GTK-Orange-Darkest-Solid";
    #   package = pkgs.flat-remix-gtk;
    # };

    # theme = {
    #   name = lib.mkForce "Flat-Remix-GTK-Orange-Darkest-Solid";
    #   package = lib.mkForce pkgs.flat-remix-gtk;
    # };

    iconTheme = {
      name = lib.mkForce "Papirus-Dark";
      package = lib.mkForce pkgs.papirus-icon-theme;
    };
  };
}
