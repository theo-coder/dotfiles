{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  environment.systemPackages = with pkgs; [
    flat-remix-gtk
  ];

  gtk = {
    enable = true;
    theme.name = "Flat-Remix-GTK-Orange-Darkest-Solid";
  };
}
