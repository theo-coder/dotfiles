{ ... }: {
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

    file.".local/share/applications/AnotherRedisDesktopManager.desktop".text = ''
      [Desktop Entry]
      Name=AnotherRedisDesktopManager
      Exec=appimage-run /home/theo/Applications/Another-Redis-Desktop-Manager-linux-1.7.1-x86_64.AppImage
      Type=Application
      Comment=AnotherRedisDesktopManager
      Icon=utilities-terminal
      Categories=Utility;
      Terminal=false
    '';

    file.".local/share/applications/BalenaEtcher.desktop".text = ''
      [Desktop Entry]
      Name=BalenaEtcher
      Exec=appimage-run /home/theo/Applications/balenaEtcher-1.18.11-x64.AppImage
      Type=Application
      Comment=BalenaEtcher
      Icon=utilities-terminal
      Categories=Utility;
      Terminal=false
    '';

    file.".local/share/applications/onlyoffice-desktopeditors.desktop".text = ''
      [Desktop Entry]
      Version=1.0
      Name=ONLYOFFICE
      GenericName=Document Editor
      Comment=Edit office documents
      Type=Application
      Exec=/nix/store/qbj3d6xzsgpkxilszpjb17yqwkmk0q5d-onlyoffice-desktopeditors-9.0.0/bin/onlyoffice-desktopeditors --enable-features=UseOzonePlatform --ozone-platform=wayland %U
      Terminal=false
      Icon=onlyoffice-desktopeditors
      Keywords=Text;Document;OpenDocument Text;Microsoft Word;Microsoft Works;odt;doc;docx;rtf;
      Categories=Office;WordProcessor;Spreadsheet;Presentation;
      MimeType=application/vnd.oasis.opendocument.text;application/vnd.oasis.opendocument.text-template;application/vnd.oasis.opendocument.text-web;application/vnd.oasis.opendocument.text-master;application/vnd.sun.xml.writer;application/vnd.sun.xml.writer.template;application/vnd.sun.xml.writer.global;application/msword;application/vnd.ms-word;application/x-doc;application/rtf;text/rtf;application/vnd.wordperfect;application/wordperfect;application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/vnd.ms-word.document.macroenabled.12;application/vnd.openxmlformats-officedocument.wordprocessingml.template;application/vnd.ms-word.template.macroenabled.12;application/vnd.oasis.opendocument.spreadsheet;application/vnd.oasis.opendocument.spreadsheet-template;application/vnd.sun.xml.calc;application/vnd.sun.xml.calc.template;application/msexcel;application/vnd.ms-excel;application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;application/vnd.ms-excel.sheet.macroenabled.12;application/vnd.openxmlformats-officedocument.spreadsheetml.template;application/vnd.ms-excel.template.macroenabled.12;application/vnd.ms-excel.sheet.binary.macroenabled.12;text/csv;text/spreadsheet;application/csv;application/excel;application/x-excel;application/x-msexcel;application/x-ms-excel;text/comma-separated-values;text/tab-separated-values;text/x-comma-separated-values;text/x-csv;application/vnd.oasis.opendocument.presentation;application/vnd.oasis.opendocument.presentation-template;application/vnd.sun.xml.impress;application/vnd.sun.xml.impress.template;application/mspowerpoint;application/vnd.ms-powerpoint;application/vnd.openxmlformats-officedocument.presentationml.presentation;application/vnd.ms-powerpoint.presentation.macroenabled.12;application/vnd.openxmlformats-officedocument.presentationml.template;application/vnd.ms-powerpoint.template.macroenabled.12;application/vnd.openxmlformats-officedocument.presentationml.slide;application/vnd.openxmlformats-officedocument.presentationml.slideshow;application/vnd.ms-powerpoint.slideshow.macroEnabled.12;x-scheme-handler/oo-office;text/docxf;text/oform;application/pdf;
      Actions=NewDocument;NewSpreadsheet;NewPresentation;NewForm;
      StartupWMClass=ONLYOFFICE

      [Desktop Action NewDocument]
      Name=New document
      Name[fr]=Nouveau document
      Exec=/nix/store/qbj3d6xzsgpkxilszpjb17yqwkmk0q5d-onlyoffice-desktopeditors-9.0.0/bin/onlyoffice-desktopeditors --enable-features=UseOzonePlatform --ozone-platform=wayland --new:word

      [Desktop Action NewSpreadsheet]
      Name=New spreadsheet
      Name[fr]=Nouveau classeur
      Exec=/nix/store/qbj3d6xzsgpkxilszpjb17yqwkmk0q5d-onlyoffice-desktopeditors-9.0.0/bin/onlyoffice-desktopeditors --enable-features=UseOzonePlatform --ozone-platform=wayland --new:cell

      [Desktop Action NewPresentation]
      Name=New presentation
      Name[fr]=Nouvelle présentation
      Exec=/nix/store/qbj3d6xzsgpkxilszpjb17yqwkmk0q5d-onlyoffice-desktopeditors-9.0.0/bin/onlyoffice-desktopeditors --enable-features=UseOzonePlatform --ozone-platform=wayland --new:slide

      [Desktop Action NewForm]
      Name=New PDF
      Name[fr]=Nouveau PDF
      Exec=/nix/store/qbj3d6xzsgpkxilszpjb17yqwkmk0q5d-onlyoffice-desktopeditors-9.0.0/bin/onlyoffice-desktopeditors --enable-features=UseOzonePlatform --ozone-platform=wayland --new:form
    '';

    file.".local/share/applications/bitwarden.desktop".text = ''
      [Desktop Entry]
      Categories=Utility
      Comment=Secure and free password manager for all of your devices
      Exec=bitwarden --enable-features=UseOzonePlatform --ozone-platform=wayland %U
      Icon=bitwarden
      MimeType=x-scheme-handler/bitwarden
      Name=Bitwarden
      Type=Application
      Version=1.5
    '';

    file.".local/share/applications/prism-launcher.desktop".text = ''
      [Desktop Entry]
      Name=Prism Launcher
      Exec=prismlauncher %U
      Terminal=false
      Type=Application
    '';

    file.".local/share/applications/Mattermost.desktop".text = ''
      [Desktop Entry]
      Name=Mattermost
      Comment=Mattermost Desktop application for Linux
      Exec=mattermost-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland %U
      Terminal=false
      Type=Application
      MimeType=x-scheme-handler/mattermost;
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

    file.".local/share/applications/Handy.desktop".text = ''
      [Desktop Entry]
      Name=Handy
      Comment=Handy
      Exec=appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage
      Terminal=false
      Type=Application
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
