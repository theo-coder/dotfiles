{
  pkgs,
  secrets,
  ...
}: {
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    nfs-utils
  ];

  boot.supportedFilesystems = [ "nfs" ];

  networking = {
    hostName = "alpha";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    hosts = secrets.hosts or {};
    wireguard.enable = true;
    firewall = {
      allowedTCPPorts = [
        53317
        8080
        8081
        3000
        57621
      ];
      allowedUDPPorts = [
        53317
        8080
        3000
        5353
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
