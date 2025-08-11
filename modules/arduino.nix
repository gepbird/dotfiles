self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      arduino
    ];

  users.users.gep.extraGroups = [ "dialout" ];
}
