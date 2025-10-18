self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      gdb
    ];

  hm-gep.xdg.configFile."gdb/gdbinit".text = ''
    set breakpoint pending on
  '';
}
