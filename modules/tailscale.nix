self:
{
  pkgs,
  ...
}:

{
  services.tailscale = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.tailscale;
  };
}
