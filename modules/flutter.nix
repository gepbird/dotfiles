self:
{
  pkgs,
  ...
}:

let
  flutter = self.lib.maybeCacheDerivation "nixpkgs-package-flutter-without-license-${self.inputs.nixpkgs.narHash}" (
    self.lib.removeLicense pkgs pkgs.flutter
  );
in
{
  hm-gep.home.packages = [
    flutter
  ];
}
