{
  inputs,
  config,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem attrValues;
  specialArgs = {
    inherit inputs;
    inherit (inputs.self) outputs;
    inherit (config) secrets;
    system = "x86_64-linux";
  };
in
{
  flake.nixosConfigurations.alpha = nixosSystem {
    inherit specialArgs;
    modules =
      (attrValues config.flake.modules.nixos)
      ++ [
        inputs.nur.modules.nixos.default
      ];
  };
}
