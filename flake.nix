{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations =
      let
        mkSystem = host: nixpkgs.lib.nixosSystem {
          modules = [
            home-manager.nixosModule
            host
            ./configuration.nix
          ];
        };
      in
      {
        geppc = mkSystem ./hosts/geppc;
        geptop = mkSystem ./hosts/geptop;
        gepvm = mkSystem ./hosts/gepvm;
      };
  };
}
