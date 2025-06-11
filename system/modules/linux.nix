{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fzf
    fd
    jq
    bat
    dust
    psmisc
    lsof
    pciutils
    usbutils
    unixtools.xxd
    iprange
    ps_mem
    bc
    dmidecode
    lshw
  ];

  services.logind = {
    powerKey = "suspend";
    lidSwitch = "suspend";
  };

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
