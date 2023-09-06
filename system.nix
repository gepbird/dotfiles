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

  # hopefully more battery time with these settings
  powerManagement = {
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  networking = {
    hostName = "geptop";
    networkmanager.enable = true;
  };

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
