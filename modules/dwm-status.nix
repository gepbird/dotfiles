self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  isLaptop = config.networking.hostName == "geptop" || config.networking.hostName == "geptop-xmg";
in
{
  services.dwm-status = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.dwm-status;
    settings = {
      order = lib.optional isLaptop "battery" ++ [
        "time"
      ];
      time = {
        format = "%F %a %r";
        update_seconds = true;
      };
    };
  };
}
