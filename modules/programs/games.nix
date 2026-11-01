{ ... }:
{
  flake.modules.nixos.games =
    { pkgs, ... }:
    {
      programs.steam.enable = true;

      environment.systemPackages = with pkgs; [
        (buildFHSEnv {
          name = "prismlauncher";
          targetPkgs =
            pkgs:
            with pkgs;
            [
              prismlauncher
              jdk17
              jdk21
              libgbm
              glib
              nss
              nspr
              atk
              at-spi2-atk
              libdrm
              expat
              libxcb
              libxkbcommon
              libx11
              libxcomposite
              libxdamage
              libxext
              libxfixes
              libxrandr
              gtk3
              pango
              cairo
              alsa-lib
              dbus
              at-spi2-core
              cups
              libxshmfence
              mesa
              libGL
              systemd
              libpulseaudio
              fontconfig
              freetype
            ];
          runScript = "prismlauncher";
          profile = ''
            export LIBGL_DRIVERS_PATH=${pkgs.mesa}/lib/dri
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
          '';
        })
      ];
    };
}
