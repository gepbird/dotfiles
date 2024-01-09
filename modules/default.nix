{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./git.nix
    ./lf.nix
    ./matlab.nix
    ./starship.nix
    ./virt-manager.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zsh.nix
  ];
}
