self:
{
  pkgs,
  ...
}:

{
  services.earlyoom = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.earlyoom;
    reportInterval = 60;
    freeSwapThreshold = 15;
    freeMemThreshold = 15;
    freeSwapKillThreshold = 5;
    freeMemKillThreshold = 10;
    # regex patterns match against values in /proc/<PID>/comm, which is truncated at 15 bytes
    extraArgs = [
      "--prefer"
      "(electron|systemd-coredum|Discord|Isolated Web|Web Content|WebExtensions|nixd|nil|clangd|OmniSharp|rust-analyzer)"
      "--avoid"
      "(OpenTablet|gromit-mpx|.flameshot-wrap|.dwm-status-wra|picom)"
      "--ignore"
      "(wireplumber|pipewire|pipewire-pulse|dbus-daemon|.gcr-ssh-agent-|ssh-agent|.agent-wrapped|gammastep|dunst|xss-lock|dconf-service|systemd)"
    ];
  };
}
