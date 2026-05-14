{
  config,
  pkgs,
  self,
  ...
}:

{
  hm-gep.programs.nh = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.nh;
    flake = "${config.hm-gep.home.homeDirectory}/dotfiles";
  };
}
