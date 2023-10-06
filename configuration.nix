{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system.nix
    ./terminal.nix
    ./desktop.nix
    ./development.nix
    ./applications.nix
  ];
}
