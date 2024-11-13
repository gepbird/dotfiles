self:
{
  pkgs,
  ...
}:

{
  # TODO: fix conflict with rustdesk-flutter
  #hm-gep.home.packages = [ pkgs.ente-auth ];
  environment.systemPackages = [ pkgs.ente-auth ];

  services.gnome.gnome-keyring.enable = true;
}
