self:
{
  ...
}:

{
  programs.adb.enable = true;

  users.users.gep.extraGroups = [ "adb" ];

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "android-udev-rules")
    (self.lib.maybeCachePackageOverlay self "android-tools")
  ];
}
