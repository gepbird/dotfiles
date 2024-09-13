self: { ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.gep.extraGroups = [ "docker" ];
}
