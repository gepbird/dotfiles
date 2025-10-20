self:
{
  pkgs,
  ...
}:

{
  programs.wireshark = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.wireshark;
  };

  users.users.gep.extraGroups = [ "wireshark" ];
}
