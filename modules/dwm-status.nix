self:
{
  config,
  lib,
  ...
}:

{
  services.dwm-status = {
    enable = true;
    settings = {
      order = lib.optional (config.networking.hostName == "geptop") "battery" ++ [
        "time"
      ];
      time = {
        format = "%F %a %r";
        update_seconds = true;
      };
    };
  };
}
