self:
{
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    self.inputs.nix-index-database.nixosModules.nix-index
  ];

  hm-gep.home.packages = with pkgs; [
    cachix
    hydra-check
    nix-diff
    nix-inspect
    nix-output-monitor
    nix-prefetch-git
    nix-tree
    nix-update
    nixd
    nixfmt-rfc-style
    nixpkgs-review
    nurl
    nvd
  ];

  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    settings =
      let
        caches = [
          {
            substituter = "https://nix-community.cachix.org";
            trusted-public-key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
          }
          {
            substituter = "https://cosmic.cachix.org";
            trusted-public-key = "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=";
          }
          {
            substituter = "https://gepbird-nur-packages.cachix.org";
            trusted-public-key = "gepbird-nur-packages.cachix.org-1:Ip2iveknanFBbJ2DFWk8cDomfRquUJiMWS/2fSeuMis=";
          }
        ];
      in
      {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = map (cache: cache.substituter) caches;
        trusted-public-keys = map (cache: cache.trusted-public-key) caches;
        trusted-users = [ "gep" ];
      };
  };

  nixpkgs.config.allowUnfree = true;
  hm-gep.home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  hm-gep.home.shellAliases = {
    bump = "nix-shell maintainers/scripts/update.nix --argstr skip-prompt true --argstr package";
    bumpc = "nix-shell maintainers/scripts/update.nix --argstr skip-prompt true --argstr commit true --argstr package";
  };

  programs.nix-index-database.comma.enable = true;
}
