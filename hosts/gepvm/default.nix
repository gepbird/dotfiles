{ lib, ... }:

{
  imports = [ ./hardware.nix ];

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
