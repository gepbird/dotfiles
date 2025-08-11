self:
{
  pkgs,
  ...
}:

let
  flutter = self.lib.cachePackage self self.lib.removeLicense pkgs pkgs.flutter;
in
{
  hm-gep.home.packages = [
    flutter
  ];
}
