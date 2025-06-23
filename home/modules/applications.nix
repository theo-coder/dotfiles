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

    file.".local/share/applications/google-chrome.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Name=Google Chrome
      GenericName=Web Browser
      Comment=Access the Internet
      Exec=/run/current-system/sw/bin/google-chrome-stable --ozone-platform=wayland --enable-features=UseOzonePlatform %U
      StartupNotify=true
      Terminal=false
      Icon=google-chrome
      Type=Application
      Categories=Network;WebBrowser;
      MimeType=application/pdf;application/rdf+xml;application/rss+xml;application/xhtml+xml;application/xhtml_xml;application/xml;image/gif;image/jpeg;image/png;image/webp;text/html;text/xml;x-scheme-handler/http;x-scheme-handler/https;
      Actions=new-window;new-private-window;

      [Desktop Action new-window]
      Name=New Window
      Exec=/run/current-system/sw/bin/google-chrome-stable --ozone-platform=wayland --enable-features=UseOzonePlatform

      [Desktop Action new-private-window]
      Name=New Incognito Window
      Exec=/run/current-system/sw/bin/google-chrome-stable --ozone-platform=wayland --enable-features=UseOzonePlatform --incognito
    '';

    file.".local/share/applications/obsidian.desktop".text = ''
      [Desktop Entry]
      Categories=Office
      Comment=Knowledge base
      Exec=obsidian --ozone-platform=wayland --enable-features=UseOzonePlatform %u
      Icon=obsidian
      MimeType=x-scheme-handler/obsidian
      Name=Obsidian
      Type=Application
      Version=1.4
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
