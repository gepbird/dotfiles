{ config, home-manager, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 4 * 1024;
  }];

  hardware.opentabletdriver.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Budapest";

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
