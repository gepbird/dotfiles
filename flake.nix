{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    # rebuilding with submodules is different until fixed:
    # https://git.lix.systems/lix-project/lix/issues/942
    # `nom build ".?submodules=1#nixosConfigurations.$(hostname).config.system.build.toplevel" && sudo result/bin/switch-to-configuration switch`
    #self = {
    #  submodules = true;
    #};

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      #url = "/home/gep/nixpkgs";
    };
    nixpkgs-patcher = {
      url = "github:gepbird/nixpkgs-patcher";
      #url = "/home/gep/nixpkgs-patcher";
    };
    nixpkgs-patch-bottom-0-11-0 = {
      url = "https://github.com/NixOS/nixpkgs/pull/431600.diff";
      flake = false;
    };
    nixpkgs-patch-bottom-0-11-1 = {
      url = "https://github.com/NixOS/nixpkgs/pull/433929.diff";
      flake = false;
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
    nvim = {
      url = "github:gepbird/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flakey-profile.follows = "";
      inputs.lix.follows = "";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # dependencies of the above modules
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    inputs:
    with inputs;
    let
      eachSystem =
        function:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (
          system: function (import nixpkgs { inherit system; })
        );
      treefmtEval = eachSystem (
        pkgs:
        treefmt-nix.lib.evalModule pkgs {
          programs.nixfmt.enable = true;
        }
      );
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    }
    // {
      lib = import ./lib.nix { };
      nixosConfigurations =
        let
          mkSystem =
            host:
            nixpkgs-patcher.lib.nixosSystem {
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
