{ ... }:
{
  flake.modules.nixos.desktop-common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wayland
        wl-clipboard
        libnotify
        brightnessctl
        ddcutil
        wtype
        wev
        keyd
        xdg-utils
        xdg-user-dirs
        glib
        gvfs
        thunar
        tumbler
        ffmpegthumbnailer
        thunar-archive-plugin
        spotify
        thunderbird
        gimp
        gthumb
        vlc
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
        config = {
          common.default = [ "gtk" ];
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
