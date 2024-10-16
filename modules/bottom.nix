self: { ... }:

{
  hm-gep.programs.bottom = {
    enable = true;
    settings = {
      flags = {
        color = "gruvbox";
        enable_gpu = true;
        default_time_value = "30s";
        memory_legend = "left";
        network_legend = "left";
      };
      processes.columns = [
        "name"
        "mem%"
        "cpu%"
        # TODO: this will be introduced in 0.9.6+
        #"gmem%"
        #"gpu%"
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
