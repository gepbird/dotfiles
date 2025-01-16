self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [ pkgs.arduino ];

  users.users.gep.extraGroups = [ "dialout" ];
}
