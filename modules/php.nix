self:
{
  pkgs,
  ...
}:

let
  composer = self.lib.maybeCacheDerivation "nixpkgs-package-composer-without-license-${self.lib.nixpkgsHash self}" (
    self.lib.removeLicense pkgs pkgs.phpPackages.composer
  );
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      phpactor
      php
    ]
    ++ [
      composer
    ];
}
