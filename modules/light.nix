{ ... }:

{
  programs.light.enable = true;
  users.users.gep.extraGroups = [ "video" ];
}
