{ ... }:
{
  flake.modules.nixos.power-storage =
    { pkgs, ... }:
    {
      services.dbus.enable = true;
      services.upower.enable = true;
      services.udev.packages = [ pkgs.ddcutil ];
      hardware.i2c.enable = true;

      powerManagement.enable = true;
      services.fwupd.enable = true;
      hardware.sensor.iio.enable = true;

      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandleLidSwitch = "suspend";
      };

      services.devmon.enable = true;
      services.gvfs.enable = true;
      services.udisks2.enable = true;
    };
}
