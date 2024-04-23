self: { pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  hm-gep.home.packages = with pkgs; [
    nix-diff
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nixpkgs-review
    nvd
  ];
}
