{...}: let
  enable = true;
in {
  hardware.bluetooth.enable = enable;
  hardware.bluetooth.powerOnBoot = false;
  services.blueman.enable = enable;
}
