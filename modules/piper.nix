self:
{
  pkgs,
  ...
}:

{
  services.ratbagd.enable = true;

  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      piper
    ];
}
