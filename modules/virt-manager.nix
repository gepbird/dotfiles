self:
{
  pkgs,
  ...
}:

{
  programs.virt-manager.enable = true;
  hm-gep.dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [
      virtiofsd
    ];
  };

  users.users.gep.extraGroups = [ "libvirtd" ];
}
