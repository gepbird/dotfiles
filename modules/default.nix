{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./atuin.nix
    ./bottom.nix
    ./clac.nix
    ./dark-theme.nix
    ./direnv.nix
    ./flameshot.nix
    ./gammastep.nix
    ./git.nix
    ./gromit-mpx.nix
    ./lf
    ./matlab.nix
    ./piper.nix
    ./rofi.nix
    ./ssh.nix
    ./starship.nix
    ./virt-manager.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
