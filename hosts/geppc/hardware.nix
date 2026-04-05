{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-6163e4e7-81f5-4e64-8908-b0235da3e2a6";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-6163e4e7-81f5-4e64-8908-b0235da3e2a6".device =
    "/dev/disk/by-uuid/6163e4e7-81f5-4e64-8908-b0235da3e2a6";
  boot.initrd.luks.devices."luks-66ba0702-cae9-4cdf-b1b0-394635d69558".device =
    "/dev/disk/by-uuid/66ba0702-cae9-4cdf-b1b0-394635d69558";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A82C-0803";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/mapper/luks-66ba0702-cae9-4cdf-b1b0-394635d69558"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
