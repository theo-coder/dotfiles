{
  inputs,
  lib,
  ...
}:
let
  localSecretsPath = /home/theo/nixos/secrets.nix;
  repoSecretsPath = ../../secrets.nix;
  exampleSecretsPath = ../../secrets.example.nix;
in
{
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  options.secrets = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
    default =
      if builtins.pathExists localSecretsPath then
        import localSecretsPath
      else if builtins.pathExists repoSecretsPath then
        import repoSecretsPath
      else
        import exampleSecretsPath;
    description = "Local personal settings and secrets loaded from secrets.nix (with fallback to secrets.example.nix).";
  };

  config = {
    systems = [ "x86_64-linux" ];
  };
}
