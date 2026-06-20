self:
{
  config,
  pkgs,
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
        memory_legend = "left";
        network_legend = "left";
        hide_k_threads = true;
        process_memory_as_value = true;
      };
      processes.columns = [
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

  # allow users to send signals to any process without sudo
  security.wrappers.btm = {
    setuid = false;
    setgid = false;
    capabilities = "cap_kill+eip";
    owner = "root";
    group = "root";
    source = "${config.hm-gep.programs.bottom.package}/bin/btm";
  };
}
