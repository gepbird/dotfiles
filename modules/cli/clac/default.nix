{ config, pkgs, ... }:

{
  hm.home = {
    packages = [ pkgs.clac ];
    file.".config/clac/words".source =
      let
        inherit (config.hm.lib.file) mkOutOfStoreSymlink;
        inherit (config.hm.home) homeDirectory;
      in
      mkOutOfStoreSymlink "${homeDirectory}/dotfiles/modules/clac/words";
  };
}
