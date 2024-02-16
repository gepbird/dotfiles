{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  hm.dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };

  # Manually add the following line to shared filesystem xmls:
  # <binary path="/run/current-system/sw/bin/virtiofsd"/>
  environment.systemPackages = [ pkgs.virtiofsd ];

  virtualisation.libvirtd.enable = true;
  users.users.gep.extraGroups = [ "libvirtd" ];

  virtualisation.vmware = {
    host.enable = true;
    guest.enable = true;
  };
}
