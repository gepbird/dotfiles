{ config, pkgs, lib, ... }:

{
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_zen;
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  # for auto mounting external storages
  services.gvfs.enable = true;

  # TODO: remove mkForce once merged: https://github.com/NixOS/nixpkgs/pull/282117
  services.upower.enable = lib.mkForce true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time = {
    timeZone = "Europe/Budapest";
    hardwareClockInLocalTime = true;
  };

  users.users.gep = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets.system-password.path;
  };
}
