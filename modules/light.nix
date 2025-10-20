self:
{
  ...
}:

{
  programs.light.enable = true;
  users.users.gep.extraGroups = [ "video" ];

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "light")
  ];
}
