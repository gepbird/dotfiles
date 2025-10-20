self:
{
  pkgs,
  ...
}:

{
  programs.slock = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.slock;
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = "/run/wrappers/bin/slock";
  };
}
