{ config, pkgs, lib, ... }:

{
  imports = [
    ./system.nix
    ./terminal.nix
    ./desktop.nix
    ./development.nix
    ./applications.nix
    ./modules
  ];

  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    efi.canTouchEfiVariables = lib.mkForce false;
    grub = {
      enable = true;
      device = "/dev/vda";
    };
  };

  networking.hostName = "gepvm";
}
