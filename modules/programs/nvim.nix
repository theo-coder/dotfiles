{ ... }:
{
  flake.modules.homeManager.nvim =
    { config, ... }:
    {
      home.file."${config.home.homeDirectory}/.config/nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/configs/nvim";
    };
}
