self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [ pkgs.rnote ];

  hm-gep.dconf.settings."com/github/flxzt/rnote" = {
    engine-config = builtins.toJSON {
      document = {
        format = {
          show_borders = false;
          show_origin_indicator = false;
        };
        background =
          let
            gray = x: {
              r = x;
              g = x;
              b = x;
              a = 1;
            };
          in
          {
            color = gray 0.118;
            pattern_color = gray 0.353;
          };
      };
    };
  };
}
