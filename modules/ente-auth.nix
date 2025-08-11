self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      ente-auth
    ];

  services.gnome.gnome-keyring.enable = true;
}
