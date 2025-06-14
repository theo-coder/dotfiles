{...}: let
  enable = true;
in {
  hardware.bluetooth.enable = enable;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = enable;
}
