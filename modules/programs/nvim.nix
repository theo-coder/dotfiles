{ ... }:
{
  flake.modules.nixos.nvim =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        neovim
      ];
    };
}
