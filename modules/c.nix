self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      clang-tools
      gcc
      gdb
      gnumake
    ];
}
