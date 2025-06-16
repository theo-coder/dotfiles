{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wayland
    wlr-randr
    wdisplays
    waybar
    wget
    tldr
    xdg-utils
    glib
    ffmpeg
    btop
    htop
    google-chrome
    zip
    unzip
    spotify
    ncspot
    playerctl
    gimp
    neohtop
    gthumb
    libnotify
    pcmanfm
    gping
    mpv
    vlc
    libreoffice-qt
    rofi-wayland
    fzf
    ripgrep
    powertop
    libinput
    acpi
    brightnessctl
    dunst
    mattermost-desktop
  ];

  programs.nm-applet.enable = true;
  powerManagement.enable = true;
  services.fwupd.enable = true;
  programs.light.enable = true;
  hardware.sensor.iio.enable = true;
}
