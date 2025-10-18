self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      docker-compose
    ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.gep.extraGroups = [ "docker" ];
}
