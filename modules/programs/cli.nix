{ ... }:
{
  flake.modules.nixos.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fzf
        fd
        jq
        bat
        dust
        ripgrep
        btop
        htop
        wget
        tldr
        zip
        unzip
        gping
        ffmpeg
        psmisc
        lsof
        pciutils
        usbutils
        unixtools.xxd
        iprange
        ps_mem
        bc
        dmidecode
        lshw
        powertop
        libinput
        acpi
        nur.repos.charmbracelet.crush
      ];
    };

  flake.modules.homeManager.cli =
    { config, ... }:
    {
      programs.fzf = {
        enable = true;
        defaultCommand = "rg --files --hidden";
        defaultOptions = [
          "--no-mouse"
          "--info=inline-right"
        ];
      };

      programs.zoxide.enable = true;
      programs.eza.enable = true;
      programs.bat.enable = true;
      programs.ripgrep.enable = true;
      programs.btop.enable = true;

      home.sessionVariables = {
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        MANROFFOPT = "-c";
        STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
      };
    };
}
