{
  config,
  lib,
  pkgs,
  self,
  ...
}:

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
    "packettracer"
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

    extraModulePackages = with config.boot.kernelPackages; [
      ryzen-smu
    ];
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
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      # ASIX AX88179A USB ethernet adapter (vendor:product, see lsusb)
      # fails after resuming from suspend
      USB_DENYLIST = "0b95:1790";
    };
  };

  # for some reason the temperature sensor turns off for the RAM, enable it on boot
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="hwmon", ATTR{name}=="spd5118", ATTR{temp1_enable}="1"
  '';

  hardware.enableAllFirmware = true;

  system.stateVersion = "25.05";
}
