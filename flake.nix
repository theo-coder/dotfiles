{
  description = "Theo's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    hyprland.url = "github:hyprwm/Hyprland";

    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprgraphics.follows = "hyprland/hyprgraphics";
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:youwen5/zen-browser-flake";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      nur,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs.lib) nixosSystem;
      localSecretsPath = /home/theo/nixos/secrets.nix;
      secrets =
        if builtins.pathExists localSecretsPath then
          import localSecretsPath
        else if builtins.pathExists ./secrets.nix then
          import ./secrets.nix
        else
          import ./secrets.example.nix;
      specialArgs = {
        inherit inputs outputs secrets;
        system = "x86_64-linux";
      };
    in
    {
      nixosConfigurations.alpha = nixosSystem {
        specialArgs = specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          nur.modules.nixos.default
          {
            home-manager.users.theo = import ./system/alpha/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
          }
          ./system/alpha/configuration.nix
        ];
      };
    };
}
