{ inputs, ... }:
{
  flake.modules.nixos.nix = {
    nixpkgs = {
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-39.8.10"
          "beekeeper-studio-6.1.1"
        ];
      };
      overlays = [
        inputs.nur.overlays.default
      ];
    };

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        download-buffer-size = 600000000;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };

    programs.nix-ld.enable = true;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}
