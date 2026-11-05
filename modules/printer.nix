self:
{
  pkgs,
  ...
}:

{
  hardware.sane.enable = true;

  users.users.gep.extraGroups = [
    "lp"
  ];

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      simple-scan
    ];
}
