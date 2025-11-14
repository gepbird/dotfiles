self:
{
  pkgs,
  ...
}:

let
  flutter = self.lib.maybeCacheDerivation "nixpkgs-package-flutter-without-license-${self.lib.nixpkgsHash self}" (
    self.lib.removeLicense pkgs pkgs.flutter
  );
in
{
  hm-gep.home.packages = [
    flutter
  ];
}
