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
            host
            home-manager.nixosModule
          ];
        };
      in
      {
        geppc = mkSystem ./configuration-geppc.nix;
        geptop = mkSystem ./configuration-geptop.nix;
        gepvm = mkSystem ./configuration-gepvm.nix;
      };
  };
}
