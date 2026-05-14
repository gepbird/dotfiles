{
  pkgs,
  self,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      android-tools
    ];
}
