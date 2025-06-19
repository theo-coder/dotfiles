{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wev
    keyd
  ];
}
