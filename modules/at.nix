self:
{
  ...
}:

{
  services.atd.enable = true;

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "at")
  ];
}
