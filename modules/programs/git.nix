{ ... }:
{
  flake.modules.nixos.git =
    { secrets, ... }:
    {
      programs.git.enable = true;

      system.activationScripts.gitLocalConfig = {
        deps = [ "users" ];
        text = ''
          mkdir -p /home/theo/.config/git
          cat << 'EOF' > /home/theo/.config/git/config.local
          [user]
          	name = ${secrets.git.name}
          	email = ${secrets.git.email}
          EOF
          chown -R theo:users /home/theo/.config/git
          chmod 600 /home/theo/.config/git/config.local
        '';
      };
    };
}
