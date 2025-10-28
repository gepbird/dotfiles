self:
{
  pkgs,
  ...
}:

{
  hm-gep.services.gammastep = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.gammastep;
    temperature = {
      day = 4000;
      night = 2700;
    };
    latitude = 42.52;
    longitude = 27.36;
  };
}
