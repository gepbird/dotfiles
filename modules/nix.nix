self:
{
  pkgs,
  nixpkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  hm-gep.home.packages = with pkgs; [
    nixd
    nix-diff
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nixpkgs-review
    nvd
  ];

  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      trusted-users = [ "gep" ];
    };
  };
}
