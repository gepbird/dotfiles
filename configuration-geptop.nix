{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./terminal.nix
    ./desktop.nix
    ./development.nix
    ./applications.nix
  ];

  networking.hostName = "geptop";
}
