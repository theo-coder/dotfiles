{ ... }:
{
  flake.modules.nixos.desktop-common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wayland
        wlr-randr
        wdisplays
        wl-clipboard
        wl-clip-persist
        clipse
        slurp
        grim
        satty
        wpaperd
        poweralertd
        libnotify
        rofi
        brightnessctl
        ddcutil
        wtype
        wev
        keyd
        xdg-utils
        xdg-user-dirs
        glib
        gvfs
        pcmanfm
        thunar
        tumbler
        ffmpegthumbnailer
        thunar-archive-plugin
        spotify
        thunderbird
        ncspot
        gimp
        gthumb
        mpv
        vlc
        libreoffice-qt
        onlyoffice-desktopeditors
        mattermost-desktop
        obsidian
        beeper
        rpi-imager
        localsend
        kdePackages.kdenlive
        audacity
        rawtherapee
        bitwarden-desktop
        mixxx
        element-desktop
        devin-desktop
      ];

      environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      services.gnome.gnome-keyring.enable = true;
      services.flatpak.enable = true;

      programs = {
        kdeconnect.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
          package = pkgs.appimage-run.override {
            extraPkgs = pkgs: [ pkgs.libxshmfence ];
          };
        };
        obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
            obs-vaapi
            obs-gstreamer
            obs-vkcapture
          ];
        };
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        wlr.enable = true;
        config = {
          common.default = [ "gtk" ];
          hyprland.default = [
            "gtk"
            "hyprland"
          ];
          niri.default = [
            "gnome"
            "gtk"
          ];
        };
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          mesa
          libva
          libva-utils
          libva-vdpau-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          mesa
          libva
        ];
      };
    };
}
