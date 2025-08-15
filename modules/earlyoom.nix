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
    # regex patterns match against values in /proc/<PID>/comm, which is truncated at 15 bytes
    extraArgs = [
      "--prefer"
      "(electron|systemd-coredum|Discord|Isolated Web|Web Content|nixd|clangd|OmniSharp)"
      "--avoid"
      "(gammastep|dunst|OpenTablet|gromit-mpx)"
      "--ignore"
      "(wireplumber|pipewire|pipewire-pulse|dbus-daemon)"
    ];
  };
}
