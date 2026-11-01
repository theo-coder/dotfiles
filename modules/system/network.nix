{ ... }:
{
  flake.modules.nixos.network =
    {
      config,
      pkgs,
      secrets,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        nfs-utils
        hostctl
        dig
        nmap
        wireguard-tools
      ];

      boot.supportedFilesystems = [ "nfs" ];

      # Make /etc/hosts a regular writable file (0644) instead of a read-only symlink to /nix/store,
      # and preserve any extra entries added in /etc/hosts.local across nixos-rebuild.
      environment.etc.hosts.mode = "0644";

      system.activationScripts.hybridHosts = {
        deps = [ "etc" ];
        text = ''
          if [ ! -f /etc/hosts.local ]; then
            cat << 'EOF' > /etc/hosts.local
          # Custom mutable host entries (persisted across nixos-rebuild).
          # Add entries here or edit /etc/hosts directly.
          EOF
            chmod 0644 /etc/hosts.local
          fi

          if [ -s /etc/hosts.local ]; then
            printf "\n# --- Entries from /etc/hosts.local ---\n" >> /etc/hosts
            cat /etc/hosts.local >> /etc/hosts
          fi
        '';
      };

      networking = {
        hostName = "alpha";
        networkmanager = {
          enable = true;
          plugins = with pkgs; [
            networkmanager-openvpn
          ];
        };
        hosts = secrets.hosts or { };
        wireguard.enable = true;
        firewall = {
          allowedTCPPorts = [
            53317
            8080
            8081
            3000
            57621
          ];
          allowedUDPPorts = [
            53317
            8080
            3000
            5353
          ];
          allowedUDPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
          allowedTCPPortRanges = [
            {
              from = 1714;
              to = 1764;
            }
          ];
        };
      };

      services.netbird.enable = true;
    };
}
