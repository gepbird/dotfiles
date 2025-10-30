self:
{
  pkgs,
  ...
}:

{
  services.geoclue2 = {
    enable = true;
  };

  hm-gep.services.gammastep = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.gammastep;
    provider = "geoclue2";
    temperature = {
      day = 4000;
      night = 2700;
    };
  };
}
