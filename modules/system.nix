self:
{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot = {
    enableContainers = true;
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      timeout = lib.mkForce 1;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # fix file copy incorrectly ending minutes earlier before it's really written on pendrives
  boot.kernel.sysctl = {
    # start background writeback at 5MB instead of 10%
    "vm.dirty_background_bytes" = 5242880;
    # block new writes at 50MB instead of 20%
    "vm.dirty_bytes" = 52428800;
    # write back anything older than 2 seconds (default is 30s)
    "vm.dirty_expire_centisecs" = 200;
    # wake up flusher thread every 1 second
    "vm.dirty_writeback_centisecs" = 100;
  };

  # for auto mounting external storages
  services.gvfs = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.gnome.gvfs;
  };

  services.upower = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.upower;
  };

  systemd.coredump.enable = false;

  networking = {
    networkmanager = {
      enable = true;
      package = self.lib.maybeCachePackage self pkgs.networkmanager;
    };
    firewall.enable = false;
  };

  time = {
    timeZone = "Europe/Budapest";
    hardwareClockInLocalTime = false;
  };

  users.users.gep = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = lib.mkIf config.enableSecrets config.secrets.gep.system-password;
    initialPassword = lib.mkIf (!config.enableSecrets) "gep";
  };

  security.sudo-rs = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.sudo-rs;
  };
}
