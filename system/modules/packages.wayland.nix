{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wayland
    wlr-randr
    wdisplays
    waybar
    wget
    tldr
    xdg-utils
    xdg-user-dirs
    glib
    ffmpeg
    btop
    htop
    google-chrome
    zip
    unzip
    spotify
    thunderbird
    ncspot
    playerctl
    gimp
    #neohtop
    gthumb
    wpaperd
    libnotify
    pcmanfm
    gping
    mpv
    vlc
    libreoffice-qt
    rofi
    fzf
    ripgrep
    powertop
    libinput
    acpi
    brightnessctl
    dunst
    mattermost-desktop
    obsidian
    beeper
    hostctl
    rpi-imager
    dig
    nmap
    wireguard-tools
    nss
    localsend
    kdePackages.kdenlive
    audacity
    nur.repos.charmbracelet.crush
    rawtherapee
    bitwarden-desktop
    onlyoffice-desktopeditors
    mixxx
    satty
    element-desktop
    nixfmt
    nil
    typescript-language-server
    tailwindcss-language-server
    prisma-language-server
    zed-editor
    thunar
    gvfs
    tumbler
    ffmpegthumbnailer
    thunar-archive-plugin
    ddcutil
    wtype
    postman
    devin-desktop
    beekeeper-studio
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
    "beekeeper-studio-6.1.1"
  ];

  services.flatpak.enable = true;
  services.netbird.enable = true;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  programs = {
    nm-applet.enable = true;
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

  powerManagement.enable = true;
  services.fwupd.enable = true;
  hardware.sensor.iio.enable = true;
}
