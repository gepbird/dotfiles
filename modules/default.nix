{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./git.nix
    ./lf.nix
    ./matlab.nix
    ./virt-manager.nix
    ./wireshark.nix
    ./zsh.nix
  ];
}
