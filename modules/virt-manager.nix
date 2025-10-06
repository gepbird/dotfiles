self:
{
  pkgs,
  ...
}:

{
  programs.virt-manager.enable = true;

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

  # for windows guests, install virti (folder sharing) and qemu-guest-utils:
  # https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win-guest-tools.exe
  # (link from https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md)
  # set VirtioFsSvc service startup type to Automatic
}
