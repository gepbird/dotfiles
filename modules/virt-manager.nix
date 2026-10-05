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

  # auto start default network
  systemd.tmpfiles.rules = [
    "L+ /var/lib/libvirt/qemu/networks/autostart/default.xml - - - - /var/lib/libvirt/qemu/networks/default.xml"
  ];

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

  # for NixOS guests, add this option for guest auto resize
  #virtualisation.vmVariant.virtualisation.qemu.options = [
  #  "-vga none"
  #  "-device virtio-vga"
  #  "-display gtk,zoom-to-fit=on"
  #];
}
