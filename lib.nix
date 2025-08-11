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

  extractImportantPackageAttrs = package: {
    inherit (package)
      type
      drvPath
      outPath
      meta
      ;
  };

  derivationToJSON =
    drv:
    builtins.toJSON {
      name = drv.type;
      pname = drv.type;
      version = drv.type;
      meta =
        if drv.meta ? mainProgram then
          {
            mainProgram = drv.meta.mainProgram;
          }
        else
          { };
      type = drv.type;
      drvPath = drv.drvPath;
      _outPath = drv.outPath;
    };
  jsonToDerivation =
    json:
    let
      drv = builtins.fromJSON json;
    in
    {
      name = drv.name;
      pname = drv.pname;
      version = drv.version;
      type = drv.type;
      meta =
        if drv.meta ? mainProgram then
          {
            mainProgram = drv.meta.mainProgram;
          }
        else
          { };
      drvPath = drv.drvPath;
      outPath = drv._outPath;
    };

  cacheString = cacheIdentifier: string: builtins.trace "cache=${cacheIdentifier}" string;
  cacheDerivation =
    cacheIdentifier: drv: jsonToDerivation (cacheString cacheIdentifier (derivationToJSON drv));
  cachePackage =
    self: package:
    cacheDerivation "nixpkgs-package-${package.name}-${self.inputs.nixpkgs.narHash}" package;
  cachePackages = self: packages: map (cachePackage self) packages;
in
{
  inherit
    mkDotfilesSymlink
    removeLicense
    derivationToJSON
    jsonToDerivation
    cacheString
    cacheDerivation
    cachePackage
    cachePackages
    ;
}
