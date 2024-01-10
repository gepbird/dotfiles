{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./atuin.nix
    ./bottom.nix
    ./clac
    ./dark-theme.nix
    ./direnv.nix
    ./firefox.nix
    ./flameshot.nix
    ./gammastep.nix
    ./git.nix
    ./gromit-mpx.nix
    ./lf
    ./matlab.nix
    ./mpv.nix
    ./onlyoffice.nix
    ./piper.nix
    ./rofi.nix
    ./ssh.nix
    ./starship.nix
    ./virt-manager.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zathura.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
