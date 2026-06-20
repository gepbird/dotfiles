self:
{
  config,
  pkgs,
  lib,
  ...
}:

{
  hm-gep.programs.bottom = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.bottom;
    settings = {
      flags = {
        color = "gruvbox";
        default_time_value = "30s";
        hide_k_threads = true;
        process_memory_as_value = true;
      };
      memory_graph = {
        legend_position = "left";
        short_gpu_names = true;
      };
      network_graph = {
        legend_position = "left";
      };
      temperature_graph = {
        legend_position = "left";
      };
      processes = {
        default_sort = "mem";
        columns = [
          "name"
          "mem"
          "cpu%"
          "gmem"
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
      };
      disk = {
        columns = [
          "mount"
          "r/s"
          "w/s"
          "used%"
          "total"
          "disk"
        ];
      };
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
              ratio = 35;
              type = "temperature_graph";
            }
            {
              ratio = 30;
              type = "disk";
            }
            {
              ratio = 35;
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

  # allow users to send signals to any process without sudo
  security.wrappers.btm = {
    setuid = false;
    setgid = false;
    capabilities = "cap_kill+eip";
    owner = "root";
    group = "root";
    source = lib.getExe config.hm-gep.programs.bottom.package;
  };
}
