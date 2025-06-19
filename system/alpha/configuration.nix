{inputs, ...}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    ../modules/common.nix
  ];

  nix.settings.download-buffer-size = 600000000;
  system.stateVersion = "25.05";
}
