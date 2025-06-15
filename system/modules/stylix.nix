{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix = {
    enable = true;
    base16Scheme = let
      theme = "kanagawa";
    in "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    #override = { base00 = "#000000"; };

    image = ../../assets/wallpapers/0290.jpg;
    polarity = "dark";

    fonts = rec {
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = sansSerif;

      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 15;
        terminal = 15;
      };
    };

    cursor = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
      size = 35;
    };
  };
}
