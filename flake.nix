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
      nixosConfigurations.gepvm = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-gepvm.nix
          ./hardware-configuration-gepvm.nix
          home-manager.nixosModule
        ];
      };
      nixosConfigurations.geppc = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-geppc.nix
          ./hardware-configuration-geppc.nix
          home-manager.nixosModule
        ];
      };
      nixosConfigurations.geptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration-geptop.nix
          ./hardware-configuration-geptop.nix
          home-manager.nixosModule
        ];
      };
    };
}
