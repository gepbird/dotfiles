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

  dontCachePackages = packages: packages;

  maybeCachePackages = self: packages: (dontCachePackages packages);
in
{
  inherit
    mkDotfilesSymlink
    removeLicense
    maybeCachePackages
    ;
}
