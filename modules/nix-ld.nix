self: { pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
  };
}
