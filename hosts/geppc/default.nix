{ self, pkgs, ... }:

{
  imports = [ ./hardware.nix ] ++
    self.nixosModules.allImportsExcept [
      "light"
      "vmware"
    ];

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-uuid/a2499480-9845-4acf-95c0-aaaab51936c6";
      fsType = "ext4";
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
      device = "/dev/disk/by-uuid/98D4C937D4C91900";
      fsType = "ntfs";
      options = [ "nofail" ];
    };
    "/nixos-vm" = {
      device = "/dev/disk/by-uuid/cb725a9a-7cc9-43f4-8639-cbc203547832";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /vm 0755 gep root"
  ];

  networking.hostName = "geppc";

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false; # when enabled lightdm is not visible
    nvidiaSettings = true;
    forceFullCompositionPipeline = false; # when enabled fixes screen tearing, but disables other monitors
  };

  home-manager.users.gep = {
    home.packages = with pkgs; [
      nvtopPackages.full
    ];
  };
}
