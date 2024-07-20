{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # TODO: remove after https://github.com/NixOS/nixpkgs/issues/324252
    nixpkgs-nvidia = {
      url = "github:NixOS/nixpkgs/b2852eb9365c6de48ffb0dc2c9562591f652242a";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dwm-gep = {
      url = "github:gepbird/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
      inputs.darwin.follows = "";
    };
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
      inputs.flake-parts.follows = "flake-parts";
      inputs.hercules-ci-effects.follows = "hercules-ci-effects";
      inputs.git-hooks.follows = "git-hooks";
    };
    # dependencies of the above modules
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
      inputs.gitignore.follows = "";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
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
