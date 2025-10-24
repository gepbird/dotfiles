self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      ente-auth
    ];

  services.gnome.gnome-keyring.enable = true;

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "grc")
  ];
}
