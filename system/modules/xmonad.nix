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
      sessionCommands = ''
        $HOME/.local/bin/displayctl
      '';
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
    ELECTRON_FORCE_DEVICE_SCALE_FACTOR = "0.5";
    GDK_SCALE = "0.5";
    GDK_DPI_SCALE = "1";
    #_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    XCURSOR_SIZE = "35";
  };
}
