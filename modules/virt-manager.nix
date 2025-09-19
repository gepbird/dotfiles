self:
{
  config,
  pkgs,
  ...
}:

{
  programs.virt-manager.enable = true;
  hm-gep.dconf.settings."org/virt-manager/virt-manager/connections" = {
    # TODO: check if this is still needed
    autoconnect = [ config.hm-gep.home.sessionVariables.LIBVIRT_DEFAULT_URI ];
    uris = [ config.hm-gep.home.sessionVariables.LIBVIRT_DEFAULT_URI ];
  };

  hm-gep.home.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [
        virtiofsd
      ];
    };
  };

  users.users.gep.extraGroups = [ "libvirtd" ];

  # for windows guests, install https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
}
