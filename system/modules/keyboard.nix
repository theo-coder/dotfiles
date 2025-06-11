{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xorg.xev
    keyd
  ];
}
