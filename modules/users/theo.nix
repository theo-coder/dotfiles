let
  userName = "theo";
  homeDir = "/home/${userName}";
  repoDir = "${homeDir}/nixos";
in
{
  flake.modules.nixos.user-theo =
    { pkgs, ... }:
    {
      users.users.${userName} = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "video"
          "docker"
          "greeter"
        ];
      };

      environment.systemPackages = [ pkgs.stow ];

      system.activationScripts.stowUserConfigs = {
        deps = [ "users" ];
        text = ''
          if [ -d "${repoDir}/configs" ]; then
            ${pkgs.sudo}/bin/sudo -u ${userName} ${pkgs.bash}/bin/bash -c '
              # Remove any leftover symlinks pointing to home-manager-files
              for dir in "${homeDir}/.config" "${homeDir}/.local" "${homeDir}/.icons" "${homeDir}/.themes"; do
                if [ -d "$dir" ]; then
                  ${pkgs.findutils}/bin/find "$dir" -type l -lname "*-home-manager-files*" -delete 2>/dev/null || true
                fi
              done
              for f in "${homeDir}/.gtkrc-2.0" "${homeDir}/.manpath" "${homeDir}/.Xresources" "${homeDir}/.config/systemd/user/dms.service" "${homeDir}/.config/systemd/user/niri.service.wants/dms.service"; do
                if [ -e "$f" ] || [ -L "$f" ]; then rm -f "$f"; fi
              done

              mkdir -p "${homeDir}/.config" "${homeDir}/.local/share/applications"
              ${pkgs.stow}/bin/stow --no-folding -R -d "${repoDir}" -t "${homeDir}" configs
            '
          fi
        '';
      };
    };
}
