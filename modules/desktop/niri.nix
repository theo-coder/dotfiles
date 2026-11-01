{ ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];

      system.activationScripts.ensureNiriDmsIncludes = {
        deps = [ "users" ];
        text = ''
          mkdir -p /home/theo/.config/niri/dms
          for f in alttab binds colors cursor input layout outputs windowrules wpblur; do
            if [ ! -f "/home/theo/.config/niri/dms/$f.kdl" ]; then
              touch "/home/theo/.config/niri/dms/$f.kdl"
            fi
          done
          chown -R theo:users /home/theo/.config/niri
        '';
      };
    };
}
