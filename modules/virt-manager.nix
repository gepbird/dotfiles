self:
{
  pkgs,
  ...
}:

{
  programs.virt-manager = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.virt-manager;
  };

  hm-gep.dconf.settings."org/virt-manager/virt-manager" = {
    "xmleditor-enabled" = true;
    "console/resize-guest" = 1;
  };

  hm-gep.home.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      package = self.lib.maybeCachePackage self pkgs.libvirt;
      qemu.vhostUserPackages =
        with pkgs;
        self.lib.maybeCachePackages self [
          virtiofsd
        ];
    };
  };

  users.users.gep.extraGroups = [ "libvirtd" ];

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "spice-gtk")
  ];

  # for windows guests, install virti (folder sharing) and qemu-guest-utils:
  # https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win-guest-tools.exe
  # (link from https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md)
  # set VirtioFsSvc service startup type to Automatic

  # fix "Error starting domain: Requested operation is not valid: network 'default' is not active":
  # virt-manager > Edit > Connection Details > Virtual Networks > default > Autostart: On Boot > enable
}
