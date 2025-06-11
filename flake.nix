{
  description = "Theo's NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs.lib) nixosSystem;
    specialArgs = {
      inherit inputs outputs;
      system = "x86_64-linux";
    };
  in {
    nixosConfigurations.alpha = nixosSystem {
      specialArgs = specialArgs;
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.theo = import ./system/alpha/home.nix;
          home-manager.extraSpecialArgs = specialArgs;
        }
        ./system/alpha/configuration.nix
      ];
    };
  };
}
