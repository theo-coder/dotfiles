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
}
