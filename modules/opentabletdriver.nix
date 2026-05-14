{
  pkgs,
  self,
  ...
}:

{
  hardware.opentabletdriver = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.opentabletdriver;
  };
}
