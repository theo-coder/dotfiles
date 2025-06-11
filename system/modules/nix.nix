{...}: {
  nix.settings.experimental-features = "nix-command flakes";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
