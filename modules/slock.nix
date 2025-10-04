self:
{
  ...
}:

{
  programs.slock.enable = true;

  programs.xss-lock = {
    enable = true;
    lockerCommand = "/run/wrappers/bin/slock";
  };
}
