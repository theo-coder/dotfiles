let
  userName = "theo";
  homeDir = "/home/${userName}";
  repoDir = "${homeDir}/nixos";
in
{
  flake.modules.nixos.user-theo = {
    users.users.${userName} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "docker"
        "greeter"
      ];
    };
  };

  flake.modules.homeManager.user-theo =
    { config, ... }:
    {
      home = {
        username = userName;
        homeDirectory = homeDir;
        stateVersion = "26.11";

        file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/configs/bin";
        file.".local/lib".source = config.lib.file.mkOutOfStoreSymlink "${repoDir}/configs/lib";
        file.".config/electron-flags.conf".text = ''
          --enable-features=UseOzonePlatform
          --ozone-platform=wayland
        '';
        file.".config/wpaperd/config.toml".text = ''
          [default]
          mode = "center"
          path = "${homeDir}/Images/wallpapers/landscape/"
        '';
      };

      programs.home-manager.enable = true;

      services.kdeconnect = {
        enable = true;
        indicator = false;
      };

      systemd.user.startServices = "sd-switch";
    };
}
