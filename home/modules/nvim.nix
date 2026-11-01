{ config, ... }:
{
  config = {
    home.file."${config.home.homeDirectory}/.config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home/config/nvim";
  };
}
