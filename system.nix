{ config, pkgs, home-manager, ... }:

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
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  home-manager.users.gep = {
    home.stateVersion = config.system.stateVersion;
  };
  system.stateVersion = "23.05";
}
