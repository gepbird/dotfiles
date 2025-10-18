self:
{
  config,
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      clac
    ];

  hm-gep.xdg.configFile."clac/words".source = self.lib.mkDotfilesSymlink config "modules/clac/words";
}
