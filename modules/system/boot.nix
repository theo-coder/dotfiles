{ ... }:
{
  flake.modules.nixos.boot =
    { pkgs, ... }:
    {
      boot = {
        plymouth.enable = true;
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
          efi.canTouchEfiVariables = true;
          timeout = 0;
        };
        kernelPackages = pkgs.linuxPackages_latest;
      };
    };
}
