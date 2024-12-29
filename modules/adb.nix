self:
{
  ...
}:

{
  programs.adb.enable = true;

  users.users.gep.extraGroups = [ "adb" ];
}
