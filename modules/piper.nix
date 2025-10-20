self:
{
  pkgs,
  ...
}:

{
  services.ratbagd = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.libratbag;
  };

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      piper
    ];
}
