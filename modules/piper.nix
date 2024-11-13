self:
{
  pkgs,
  ...
}:

{
  services.ratbagd.enable = true;

  hm-gep.home.packages = [ pkgs.piper ];
}
