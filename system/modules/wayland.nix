{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
    glib
    waybar
    slurp
    grim
    hyprpolkitagent
    wl-clip-persist
    clipse
    hypridle
    poweralertd
    hyprlock
    faac
    faad2
    glib
    gvfs
  ];

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

  services.gnome.gnome-keyring.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libva-utils
      vaapiVdpau
      libvdpau-va-gl
      amdvlk
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      libva
      amdvlk
    ];
  };
}
