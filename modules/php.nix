self:
{
  pkgs,
  ...
}:

let
  composer = self.lib.removeLicense pkgs pkgs.php84Packages.composer;
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      phpactor
      php
      composer
    ];
}
