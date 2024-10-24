{ self, ... }:

{
  imports = [ ./hardware.nix ] ++
    self.nixosModules.allImportsExcept [
      "flutter"
      "games"
      "java"
      "nvidia"
      "piper"
      "virt-manager"
      "vmware"
    ];

  networking.hostName = "geptop";

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
}
