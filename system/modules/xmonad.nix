{pkgs, ...}: {
  services.xserver = {
    displayManager = {
      lightdm.greeters.slick = {
        enable = true;
        theme.name = "Stylix";
        extraConfig = ''
          [Greeter]
          enable-hidpi=on
          xft-dpi=196
        '';
      };
    };
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
    xkb.options = "eurosign:e,caps:escape";
    dpi = 144;
  };

  environment.systemPackages = with pkgs; [
    xmobar
  ];

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    XCURSOR_SIZE = "32";
  };
}
