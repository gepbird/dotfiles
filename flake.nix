{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.geppc = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-geppc.nix
          ./hardware-configuration-geppc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
      nixosConfigurations.geptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-geptop.nix
          ./hardware-configuration-geptop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
    };
}
