{pkgs, ...}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "theo";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };

  # services.gnome.gnome-keyring.enable = true;

  # services.xserver = {
  #   displayManager = {
  #     lightdm.greeters.slick = {
  #       enable = true;
  #       theme.name = "Stylix";
  #       extraConfig = ''
  #         [Greeter]
  #         enable-hidpi=on
  #         xft-dpi=196
  #       '';
  #     };
  #     sessionCommands = ''
  #       $HOME/.local/bin/displayctl
  #     '';
  #   };
  #   enable = true;
  #   windowManager.xmonad = {
  #     enable = true;
  #     enableContribAndExtras = true;
  #   };
  #   xkb.options = "eurosign:e,caps:escape";
  #   dpi = 144;
  # };
  #
  # environment.systemPackages = with pkgs; [
  #   xmobar
  # ];
  #
  # environment.variables = {
  #   ELECTRON_FORCE_DEVICE_SCALE_FACTOR = "0.5";
  #   GDK_SCALE = "0.5";
  #   GDK_DPI_SCALE = "1";
  #   #_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  #   XCURSOR_SIZE = "35";
  # };
}
