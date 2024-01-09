{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./virt-manager.nix
    ./wireshark.nix
  ];
}
