{ self, config, pkgs, ... }:

{
  hm.home = {
    packages = [ pkgs.clac ];
    file.".config/clac/words".source =
      self.lib.mkDotfilesSymlink config "modules/clac/words";
  };
}
