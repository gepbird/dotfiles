{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./terminal.nix
    ./desktop.nix
    ./development.nix
    ./applications.nix
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
      device = "/dev/disk/by-uuid/F6084FBD084F7C1D";
      fsType = "ntfs";
      options = [ "nofail" ];
    };
    "/windows" = {
      device = "/dev/disk/by-uuid/F6DC963EDC95F957";
      fsType = "ntfs";
      options = [ "nofail" ];
    };
  };

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
      nvtop
    ];
  };
}
