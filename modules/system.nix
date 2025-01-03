self:
{
  config,
  pkgs,
  ...
}:

{
  boot = {
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
  services.gvfs.enable = true;

  services.upower.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  time = {
    timeZone = "Europe/Budapest";
    hardwareClockInLocalTime = true;
  };

  users.users.gep = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets.system-password.path;
  };

  system.stateVersion = "23.05";
}
