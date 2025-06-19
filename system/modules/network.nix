{pkgs, ...}: {
  environment.systemPackages = with pkgs; [networkmanagerapplet];

  networking = {
    hostName = "alpha";
    networkmanager.enable = true;
  };
}
