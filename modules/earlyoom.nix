self:
{
  ...
}:

{
  services.earlyoom = {
    enable = true;
    reportInterval = 60;
    freeSwapThreshold = 20;
    freeMemThreshold = 20;
    freeSwapKillThreshold = 10;
    freeMemKillThreshold = 15;
  };
}
