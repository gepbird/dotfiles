{ self, config, pkgs, ... }:

{
  hm.home.packages = [ pkgs.clac ];

  hm.xdg.configFile."clac/words".source =
    self.lib.mkDotfilesSymlink config "modules/clac/words";
}
