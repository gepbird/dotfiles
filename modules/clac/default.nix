self:
{
  config,
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [ pkgs.clac ];

  hm-gep.xdg.configFile."clac/words".source = self.lib.mkDotfilesSymlink config "modules/clac/words";
}
