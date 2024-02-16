{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./agenix.nix
    ./cli
    ./dark-theme.nix
    ./discord.nix
    ./feh.nix
    ./firefox.nix
    ./flameshot.nix
    ./gammastep.nix
    ./gromit-mpx.nix
    ./matlab.nix
    ./mpv.nix
    ./onlyoffice.nix
    ./piper.nix
    ./rofi.nix
    ./virtualisation.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zathura.nix
  ];
}
