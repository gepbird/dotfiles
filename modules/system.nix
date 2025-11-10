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
    hashedPasswordFile =
      config.age.secrets.system-password.path or (toString (
        pkgs.writeText "system-password-stub" "$6$Z6Mge73J$mBdqB5EcjwEb/QifNdBPVyVgeIz6hL4RQpDGACssXrCShUkVyEdehBAzPEltCfNXZof5Icg3aRoRa3nlaPtAH."
      ));
  };

  security.sudo-rs = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.sudo-rs;
  };
}
