self:
{
  pkgs,
  ...
}:

{
  hardware.opentabletdriver = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.opentabletdriver;
  };
}
