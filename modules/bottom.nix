self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.bottom = {
    enable = true;
    package = pkgs.bottom.overrideAttrs (o: {
      patches = (o.patches or [ ]) ++ [
        (pkgs.fetchpatch2 {
          # https://github.com/ClementTsang/bottom/pull/1791
          name = "short-gpu-name-in-memory-widget.patch";
          url = "https://github.com/ClementTsang/bottom/pull/1791/commits/78f6de9a5204d5578f2c6e7560747d761e931b1d.patch";
          hash = "sha256-9AL0MF4Q/urn5KsOHT1eaIIWNtuCf7rUabqMsY9Mmd4=";
        })
      ];
    });
    settings = {
      flags = {
        color = "gruvbox";
        default_time_value = "30s";
        memory_legend = "left";
        network_legend = "left";
      };
      processes.columns = [
        "name"
        "mem%"
        "cpu%"
        "gmem%"
        "gpu%"
        "pid"
        "read"
        "write"
        "tread"
        "twrite"
        "state"
        "user"
        "time"
      ];
      disk.columns = [
        "mount"
        "r/s"
        "w/s"
        "used%"
        "total"
        "disk"
      ];
      row = [
        {
          ratio = 40;
          child = [
            {
              type = "mem";
            }
            {
              type = "cpu";
            }
          ];
        }
        {
          ratio = 30;
          child = [
            {
              ratio = 20;
              type = "temp";
            }
            {
              ratio = 50;
              type = "disk";
            }
            {
              ratio = 40;
              type = "net";
            }
          ];
        }
        {
          ratio = 30;
          child = [
            {
              ratio = 60;
              type = "proc";
            }
          ];
        }
      ];
    };
  };
}
