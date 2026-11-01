{ inputs, ... }:
{
  flake.modules.nixos.greeter = {
    imports = [ inputs.dux-greeter.nixosModules.default ];

    programs.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/theo";
    };

    services.fprintd.enable = true;

    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      fprintAuth = true;
    };
  };
}
