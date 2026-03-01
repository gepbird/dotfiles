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
      timeout = 1;
      efi.canTouchEfiVariables = true;
      grub = {
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
      };
    };
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
