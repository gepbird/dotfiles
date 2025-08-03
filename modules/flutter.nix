self:
{
  pkgs,
  ...
}:

let
  flutter = self.lib.removeLicense pkgs pkgs.flutter;
in
{
  hm-gep.home.packages = [
    flutter
  ];
}
