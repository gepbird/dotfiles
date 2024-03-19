self: { pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "repl-flake"
  ];

  hm.home.packages = with pkgs; [
    nixpkgs-review
    nix-prefetch-git
  ];

  system.stateVersion = "23.05";
}
