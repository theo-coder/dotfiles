{...}: {
  config.home = {
    file.".local/share/applications/spotify.desktop".text = ''
      [Desktop Entry]
      Name=Spotify
      Comment=Spotify Desktop application for Linux
      Exec=spotify --enable-features=UseOzonePlatform --ozone-platform=wayland %U
      Terminal=false
      Type=Application
      MimeType=x-scheme-handler/spotify;
      Icon=spotify-client
      Categories=Audio;Music;Player;AudioVideo;
    '';

    file.".local/share/applications/Mattermost.desktop".text = ''
      [Desktop Entry]
      Name=Mattermost
      Comment=Mattermost Desktop application for Linux
      Exec=mattermost-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland %U
      Terminal=false
      Type=Application
      MimeType=x-scheme-handler/mattermost
      Icon=mattermost-desktop
      Categories=Network;InstantMessaging;
    '';
  };

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "application/xhtml+xml" = "zen.desktop";
  #     "text/html" = "zen.desktop";
  #     "text/xml" = "zen.desktop";
  #     "x-scheme-handler/ftp" = "zen.desktop";
  #     "x-scheme-handler/http" = "zen.desktop";
  #     "x-scheme-handler/https" = "zen.desktop";
  #   };
  # };
}
