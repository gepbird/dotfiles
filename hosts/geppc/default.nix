{
  self,
  ...
}:

{
  imports = [
    ./hardware.nix
  ]
  ++ self.nixosModules.allImportsExcept [
    "anydesk-download"
    "flutter"
    "latex"
    "light"
    "network-bridge"
    "php"
    "vmware"
  ];

  fileSystems = {
    "/hdd" = {
      device = "/dev/disk/by-uuid/a2499480-9845-4acf-95c0-aaaab51936c6";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/hdd2" = {
      device = "/dev/disk/by-uuid/E670ED8170ED58B7";
      fsType = "ntfs";
      options = [ "nofail" ];
    };
    "/steam" = {
      device = "/dev/disk/by-uuid/ea9ffffd-d61f-4ad2-9ead-5e3a1fe6276e";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/winchi" = {
      device = "/dev/disk/by-uuid/bfd2931c-b7a1-429b-adfe-4ec2dc8390e2";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
    "/windows" = {
      device = "/dev/disk/by-uuid/4AF26EFCF26EEB9F";
      fsType = "ntfs";
      options = [ "nofail" ];
    };
    "/ssd" = {
      device = "/dev/disk/by-uuid/df6f7312-7a1d-4008-af27-cd77bb613f0b";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
  };

  networking.hostName = "geppc";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  system.stateVersion = "24.11";
}
