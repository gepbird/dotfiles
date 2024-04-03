self: { config, lib, ... }:

{
  #services.dwm-status = {
  #  enable = true;
  #  order = lib.optional (config.networking.hostName == "geptop") "battery" ++ [
  #    "time"
  #  ];
  #  extraConfig = ''
  #    [time]
  #    format = "%F %a %r"
  #    update_seconds = true
  #  '';
  #};

}
