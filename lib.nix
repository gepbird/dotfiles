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

  nixpkgsHash =
    self:
    let
      lib = self.inputs.nixpkgs.lib;
      relevantInputs = lib.filterAttrs (name: value: lib.hasPrefix "nixpkgs" name) self.inputs;
      inputHashes = lib.mapAttrsToList (name: value: value.narHash) relevantInputs;
      inputsHash = builtins.hashString "sha256" (lib.concatStrings inputHashes);
      inputsHashShort = lib.substring 0 4 inputsHash;
    in
    "${self.inputs.nixpkgs.narHash}-${inputsHashShort}";

  doCacheDerivations = true;

  cacheDerivation = cacheKey: derivation: builtins.trace "cache=${cacheKey}" derivation;
  cachePackage =
    self: package: cacheDerivation "nixpkgs-package-${package.name}-${nixpkgsHash self}" package;

  maybeCacheDerivation =
    cacheKey: derivation:
    if doCacheDerivations then cacheDerivation cacheKey derivation else derivation;
  maybeCachePackage =
    self: package: if doCacheDerivations then cachePackage self package else package;
  maybeCachePackages =
    self: packages: if doCacheDerivations then map (maybeCachePackage self) packages else packages;
  maybeCachePackageOverlay =
    self: packageName: final: prev:
    if doCacheDerivations then
      {
        "${packageName}" = cachePackage self (prev."${packageName}");
      }
    else
      { };
in
{
  inherit
    mkDotfilesSymlink
    removeLicense
    nixpkgsHash
    maybeCacheDerivation
    maybeCachePackage
    maybeCachePackages
    maybeCachePackageOverlay
    ;
}
