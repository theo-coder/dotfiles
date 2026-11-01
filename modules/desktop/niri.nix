{ ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
    };

  flake.modules.homeManager.niri =
    {
      config,
      lib,
      ...
    }:
    {
      home.file.".config/niri/config.kdl".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/configs/niri/config.kdl";

      home.activation.ensureNiriDmsIncludes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "${config.home.homeDirectory}/.config/niri/dms"
        for f in alttab binds colors cursor input layout outputs windowrules wpblur; do
          if [ ! -f "${config.home.homeDirectory}/.config/niri/dms/$f.kdl" ]; then
            touch "${config.home.homeDirectory}/.config/niri/dms/$f.kdl"
          fi
        done
      '';
    };
}
