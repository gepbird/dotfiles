{
  ...
}:

let
  # This function expects this repository to be at ~/dotfiles
  mkDotfilesSymlink =
    config: pathFromHome:
    config.hm-gep.lib.file.mkOutOfStoreSymlink "${config.hm-gep.home.homeDirectory}/dotfiles/${pathFromHome}";

  # https://github.com/NixOS/nixpkgs/issues/254265
  removeLicense =
    pkgs: pkg:
    pkgs.symlinkJoin {
      name = "${pkg.name}-no-license";
      paths = [ pkg ];
      postBuild = ''
        rm -f $out/LICENSE
      '';
    };

  doCacheDerivations = false;

  cacheDerivation = cacheKey: derivation: throw "Caching derivations is not yet supported";
  cachePackage = self: package: throw "Caching derivations is not yet supported";

  maybeCacheDerivation =
    cacheKey: derivation:
    if doCacheDerivations then cacheDerivation cacheKey derivation else derivation;
  maybeCachePackage = self: package: if doCacheDerivations then cachePackage self package else package;
  maybeCachePackages =
    self: packages: if doCacheDerivations then map (maybeCachePackage self) packages else packages;
in
{
  inherit
    mkDotfilesSymlink
    removeLicense
    maybeCacheDerivation
    maybeCachePackage
    maybeCachePackages
    ;
}
