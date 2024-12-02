self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [ pkgs.ente-auth ];

  services.gnome.gnome-keyring.enable = true;
}
