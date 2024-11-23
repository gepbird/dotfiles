self:
{
  ...
}:

{
  hm-gep.programs.bottom = {
    enable = true;
    settings = {
      flags = {
        color = "gruvbox";
        # TODO: remove in >0.10.2 (https://github.com/ClementTsang/bottom/pull/1559)
        enable_gpu = true;
        default_time_value = "30s";
        memory_legend = "left";
        network_legend = "left";
      };
      processes.columns = [
        "name"
        "mem%"
        "cpu%"
        # TODO: gpu doesn't work yet: https://github.com/ClementTsang/bottom/issues/1629
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
              ratio = 30;
              type = "temp";
            }
            {
              ratio = 70;
              type = "disk";
            }
          ];
        }
        {
          ratio = 30;
          child = [
            {
              ratio = 40;
              type = "net";
            }
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
