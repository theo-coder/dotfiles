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

    file.".local/share/applications/steam.desktop".text = ''
      [Desktop Entry]
      Name=Steam
      Comment=Application for managing and playing games on Steam
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform %U
      Icon=steam
      Terminal=false
      Type=Application
      Categories=Network;FileTransfer;Game;
      MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
      Actions=Store;Community;Library;Servers;Screenshots;News;Settings;BigPicture;Friends;
      PrefersNonDefaultGPU=true
      X-KDE-RunOnDiscreteGpu=true

      [Desktop Action Store]
      Name=Store
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://store

      [Desktop Action Community]
      Name=Community
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://url/CommunityHome/

      [Desktop Action Library]
      Name=Library
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/games

      [Desktop Action Servers]
      Name=Servers
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/servers

      [Desktop Action Screenshots]
      Name=Screenshots
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/screenshots

      [Desktop Action News]
      Name=News
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://openurl/https://store.steampowered.com/news

      [Desktop Action Settings]
      Name=Settings
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/settings

      [Desktop Action BigPicture]
      Name=Big Picture
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/bigpicture

      [Desktop Action Friends]
      Name=Friends
      Exec=steam --ozone-platform=wayland --enable-features=UseOzonePlatform steam://open/friends
    '';

    file.".local/share/applications/beepertexts.desktop".text = ''
      [Desktop Entry]
      Name=Beeper
      Exec=beeper --no-sandbox --ozone-platform=wayland --enable-features=UseOzonePlatform %U
      Terminal=false
      Type=Application
      Icon=beepertexts
      StartupWMClass=Beeper
      X-AppImage-Version=4.0.747
      Comment=The ultimate messaging app
      MimeType=x-scheme-handler/beeper;
      Categories=Network;
    '';

    file.".local/share/applications/cursor.desktop".text = ''
      [Desktop Entry]
      Actions=new-empty-window
      Categories=Utility;TextEditor;Development;IDE
      Comment=Code Editing. Redefined.
      Exec=cursor --ozone-platform=wayland --enable-features=UseOzonePlatform %F
      GenericName=Text Editor
      Icon=cursor
      Keywords=vscode
      Name=Cursor
      StartupNotify=true
      StartupWMClass=cursor
      Type=Application
      Version=1.4

      [Desktop Action new-empty-window]
      Exec=cursor --ozone-platform=wayland --enable-features=UseOzonePlatform --new-window %F
      Icon=cursor
      Name=New Empty Window
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
