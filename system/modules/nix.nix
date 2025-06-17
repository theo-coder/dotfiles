{...}: {
  nix.settings.experimental-features = "nix-command flakes";

  programs.nix-ld.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
