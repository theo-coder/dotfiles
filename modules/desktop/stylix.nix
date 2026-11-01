{ inputs, ... }:
{
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.jetbrains-mono
      ];

      stylix.targets.kmscon.enable = false;
      stylix = {
        enable = true;
        base16Scheme =
          let
            theme = "kanagawa";
          in
          "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

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
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };

          sizes = {
            applications = 10;
            desktop = 10;
            popups = 10;
            terminal = 10;
          };
        };

        cursor = {
          name = "Numix-Cursor";
          package = pkgs.numix-cursor-theme;
          size = 35;
        };
      };
    };

  flake.modules.homeManager.stylix =
    {
      pkgs,
      lib,
      ...
    }:
    {
      stylix.targets.dank-material-shell.enable = false;

      fonts.fontconfig.enable = true;

      gtk = {
        enable = true;
        iconTheme = {
          name = lib.mkForce "Papirus-Dark";
          package = lib.mkForce pkgs.papirus-icon-theme;
        };
      };
    };
}
