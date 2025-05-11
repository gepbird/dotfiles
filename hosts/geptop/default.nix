{
  self,
  ...
}:

{
  imports =
    [ ./hardware.nix ]
    ++ self.nixosModules.allImportsExcept [
      "droidcam"
      "flutter"
      "games"
      "java"
      "matlab"
      "nvidia"
      "php"
      "piper"
      "vmware"
    ];

  networking.hostName = "geptop";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
    {
      device = "/var/lib/swapfile-os-project";
      size = 8 * 1024;
    }
  ];

  # while using firefox: radeon 0000:00:01.0: ring 0 stalled for more than 10280msec
  # https://bugzilla.kernel.org/show_bug.cgi?id=85421
  # maybe helps: https://forums.linuxmint.com/viewtopic.php?t=361652
  boot.kernelParams = [
    "radeon.hard_reset=1"
    "radeon.dpm=0"
  ];
  # TODO: try disabling it in the future
  #boot.blacklistedKernelModules = [ "radeon" ];

  # hopefully more battery time with these settings
  powerManagement = {
    # probably doesn't work: Failed to find module 'cpufreq_schedutil'
    # https://github.com/NixOS/nixpkgs/issues/204619
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

  system.stateVersion = "23.05";
}
