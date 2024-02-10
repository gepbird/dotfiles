{ pkgs, ... }:

{
  services.ratbagd.enable = true;

  hm.home.packages = [ pkgs.piper ];
}
