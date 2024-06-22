{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # TODO: remove when merged: https://github.com/NixOS/nixpkgs/pull/298407
    nixpkgs-stylelint-lsp = {
      url = "github:gepbird/nixpkgs/stylelint-lsp-init";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm-gep = {
      url = "github:gepbird/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.darwin.follows = "";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: with inputs; {
    lib = import ./lib.nix { };
    nixosConfigurations =
      let
        mkSystem = host: nixpkgs.lib.nixosSystem {
          modules = [ host ];
          specialArgs = inputs;
        };
      in
      {
        geppc = mkSystem ./hosts/geppc;
        geptop = mkSystem ./hosts/geptop;
        gepvm = mkSystem ./hosts/gepvm;
      };
    nixosModules = import ./modules self;
  };
}
