self:
{
  pkgs,
  ...
}:

let
  composer = self.lib.maybeCacheDerivation "nixpkgs-package-composer-without-license-${self.inputs.nixpkgs.narHash}" (
    self.lib.removeLicense pkgs pkgs.composer
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
