{ inputs, ... }:
{
  flake.modules.nixos.alpha-hardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6a5212b8-e7d4-44ac-926d-a3e86ff03898";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/29A8-1A2F";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
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

      swapDevices = [
        { device = "/dev/disk/by-uuid/85ed2029-2897-4f00-b24e-18d133995e18"; }
      ];

      networking.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      environment.systemPackages = [ pkgs.fw-ectool ];

      systemd.services.theo-ectool-monitor = {
        description = "Read fan RPM from ectool and write to /tmp/ectool-fan-rpm";
        wantedBy = [ "multi-user.target" ];
        script =
          let
            sed = "${pkgs.gnused}/bin/sed";
            ectool = "${pkgs.fw-ectool}/bin/ectool";
          in
          ''
            while :
            do
                rpm1=$(${ectool} pwmgetfanrpm | ${sed} -rn 's/Fan 0 RPM: ([0-9]+)/\1/p')
                rpm2=$(${ectool} pwmgetfanrpm | ${sed} -rn 's/Fan 1 RPM: ([0-9]+)/\1/p')
                echo "$rpm1 $rpm2" > /tmp/ectool-fan-rpm
                sleep 2
            done
          '';
      };

      system.stateVersion = "25.11";
    };
}
