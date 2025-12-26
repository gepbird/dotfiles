self:
{
  pkgs,
  ...
}:

{
  programs.ente-auth = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.ente-auth;
  };

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "grc")
  ];
}
