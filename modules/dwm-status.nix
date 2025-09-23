self:
{
  config,
  lib,
  ...
}:

let
  isLaptop = config.networking.hostName == "geptop" || config.networking.hostName == "geptop-xmg";
in
{
  services.dwm-status = {
    enable = true;
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
