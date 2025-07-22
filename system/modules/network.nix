{pkgs, ...}: {
  environment.systemPackages = with pkgs; [networkmanagerapplet];

  networking = {
    hostName = "alpha";
    networkmanager.enable = true;
    hosts = {
      "127.0.0.1" = ["lyons-andelle-tourisme.local"];
      # "192.168.1.252" = ["pihole.kube-prod.home.posty.lan"];
      "192.168.1.253" = ["kube-prod.home.posty.lan"];
    };
    wireguard.enable = true;
  };
}
