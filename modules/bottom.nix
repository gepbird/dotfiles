self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.bottom = {
    enable = true;
    # TODO: remove after merged: https://github.com/NixOS/nixpkgs/pull/360568
    package = pkgs.bottom.overrideAttrs (o: {
      buildInputs = (o.buildInputs or []) ++ [
        pkgs.autoAddDriverRunpath
      ];
    });
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
