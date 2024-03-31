self: { pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  hm-gep.home.packages = with pkgs; [
    nix-index
    nix-prefetch-git
    nixpkgs-review
  ];

  system.stateVersion = "23.05";
}
