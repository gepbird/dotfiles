{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./atuin.nix
    ./bottom.nix
    ./clac.nix
    ./dark-theme.nix
    ./direnv.nix
    ./git.nix
    ./lf.nix
    ./matlab.nix
    ./ssh.nix
    ./starship.nix
    ./virt-manager.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
