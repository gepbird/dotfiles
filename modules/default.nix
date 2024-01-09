{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./git.nix
    ./matlab.nix
    ./virt-manager.nix
    ./wireshark.nix
  ];
}
