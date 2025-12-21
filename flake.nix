{
  description = "My NixOS configuration for my PC and laptop";

  inputs = {
    # required for dotfiles-work submodule
    # https://git.lix.systems/lix-project/lix/issues/942
    # this doesn't work when using this flake in another flake
    #self.submodules = true;
    # for now use the long command:
    # `nom build ".?submodules=1#nixosConfigurations.$(hostname).config.system.build.toplevel" && sudo result/bin/switch-to-configuration switch`

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
      #url = "/home/gep/nixpkgs";
    };
    nixpkgs-patcher = {
      url = "github:gepbird/nixpkgs-patcher";
      #url = "/home/gep/nixpkgs-patcher";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "";
    };
    dwm-gep = {
      url = "github:gepbird/dwm";
      inputs.nixpkgs.follows = "";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "";
      inputs.home-manager.follows = "";
      inputs.systems.follows = "";
      inputs.darwin.follows = "";
    };
    nvim-gep = {
      url = "github:gepbird/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flakey-profile.follows = "";
      inputs.lix.follows = "";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "";
      inputs.flake-parts.follows = "flake-parts";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "";
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
          geptop-xmg = mkSystem ./hosts/geptop-xmg;
          gepvm = mkSystem ./hosts/gepvm;
        };

      inherit inputs;
      lib = import ./lib.nix { };
      nixosModules = import ./modules self;

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://gepbird-nur-packages.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "gepbird-nur-packages.cachix.org-1:Ip2iveknanFBbJ2DFWk8cDomfRquUJiMWS/2fSeuMis="
    ];
  };
}
