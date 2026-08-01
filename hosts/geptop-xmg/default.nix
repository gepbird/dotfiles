{
  config,
  lib,
  pkgs,
  self,
  ...
}:

let
  testDwmaMotorcomm = false;
in
{
  imports = [
    ./hardware.nix
  ]
  ++ self.nixosModules.allImportsExcept [
    "anydesk-download"
    "droidcam"
    "flutter"
    "java"
    "latex"
    "network-bridge"
    "nvidia"
    "php"
    "piper"
  ];

  boot = {
    initrd = {
      luks.devices.cryptroot.device = "/dev/disk/by-label/NIXOS_LUKS";
      kernelModules = [
        "cryptd"
        "dm-snapshot"
        "ryzen_smu"
      ];
    };

    kernelPackages = lib.mkIf testDwmaMotorcomm (lib.mkForce pkgs.linuxPackages_latest);

    extraModulePackages =
      with config.boot.kernelPackages;
      [
        ryzen-smu
      ]
      ++ (lib.optional (!testDwmaMotorcomm) yt6801);

    # dwmac-motorcomm/stmmac's interrupt handling storms and soft-locks the
    # CPU on this NIC; blacklist it so the vendor yt6801 driver binds instead.
    blacklistedKernelModules = lib.optional (!testDwmaMotorcomm) "dwmac_motorcomm";
  };

  networking.hostName = "geptop-xmg";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # TODO: switch to highest and adapt applications to it
  services.xserver.resolutions = [
    {
      x = 1920;
      y = 1200;
    }
  ];

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

  hardware.enableAllFirmware = true;

  system.stateVersion = "25.05";
}
