{ lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
    ./agenix.nix
    ./atuin.nix
    ./bottom.nix
    ./clac
    ./cli.nix
    ./dark-theme.nix
    ./direnv.nix
    ./discord.nix
    ./feh.nix
    ./file-roller.nix
    ./firefox.nix
    ./flameshot.nix
    ./games.nix
    ./gammastep.nix
    ./git.nix
    ./gromit-mpx.nix
    ./gui.nix
    ./lf
    ./matlab.nix
    ./mpv.nix
    ./onlyoffice.nix
    ./piper.nix
    ./rofi.nix
    ./sound.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./virtualisation.nix
    ./vscode.nix
    ./wireshark.nix
    ./xfce4-terminal.nix
    ./zathura.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
