{pkgs, ...}: {
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "prismlauncher";
      targetPkgs = pkgs:
        with pkgs; [
          prismlauncher
          jdk17
          jdk21

          # Your required dependencies
          libgbm
          glib
          nss
          nspr
          atk
          at-spi2-atk
          libdrm
          expat
          xorg.libxcb
          libxkbcommon
          xorg.libX11
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXext
          xorg.libXfixes
          xorg.libXrandr
          gtk3
          pango
          cairo
          alsa-lib
          dbus
          at-spi2-core
          cups
          xorg.libxshmfence

          # Additional common dependencies for Minecraft
          mesa
          libGL
          systemd
          libpulseaudio
          fontconfig
          freetype
        ];
      runScript = "prismlauncher";

      # Set up environment for better compatibility
      profile = ''
        export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
      '';
    })
  ];
}
