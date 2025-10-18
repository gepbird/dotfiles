self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      arduino
    ];

  users.users.gep.extraGroups = [ "dialout" ];
}
