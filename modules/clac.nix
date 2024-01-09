{ pkgs, hm, ... }:

{
  hm.home = {
    packages = [ pkgs.clac ];
    file.".config/clac/words".source = ../home/.config/clac/words;
  };
}
