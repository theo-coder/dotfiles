{config, ...}: {
  config = {
    home.file.".local/share/applications".source = config.lib.file.mkOutOfStoreSymlink ../config/applications;
  };
}
