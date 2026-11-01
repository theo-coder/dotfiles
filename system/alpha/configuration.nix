{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
    ../modules/common.nix
  ];

  nix.settings.download-buffer-size = 600000000;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  fileSystems."/mnt/media" = {
    device = "192.168.1.207:/mnt/tank/media";
    fsType = "nfs";
    options = [
      "defaults"
      "x-systemd.automount"
      "x-systemd.idle_timeout=30s"
    ];
  };

  system.stateVersion = "25.11";
}
