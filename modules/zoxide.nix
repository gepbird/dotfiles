{
  pkgs,
  self,
  ...
}:

{
  hm-gep.programs.zoxide = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.zoxide;
  };
}
