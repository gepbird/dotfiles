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
}