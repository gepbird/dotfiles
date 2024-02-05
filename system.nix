{ config, pkgs, lib, home-manager, ... }:

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

  hardware.opentabletdriver.enable = true;

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

  console.useXkbConfig = true;

  users.users.gep = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets.system-password.path;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager.useGlobalPkgs = true;

  home-manager.users.gep = {
    home.stateVersion = config.system.stateVersion;
  };
  system.stateVersion = "23.05";
}
