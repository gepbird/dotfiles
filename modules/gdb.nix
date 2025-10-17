self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    gdb
  ];

  hm-gep.xdg.configFile."gdb/gdbinit".text = ''
    set breakpoint pending on
  '';
}
