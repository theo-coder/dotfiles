{pkgs, ...}: {
  environment.systemPackages = with pkgs; [networkmanagerapplet];

  networking = {
    hostName = "alpha";
    networkmanager.enable = true;
    hosts = {
      "127.0.0.1" = ["lyons-andelle-tourisme.local"];
    };
  };
}
