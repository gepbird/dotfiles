{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./matlab.nix
    ./virt-manager.nix
    ./wireshark.nix
  ];
}
