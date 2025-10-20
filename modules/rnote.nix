self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      rnote
    ];

  hm-gep.dconf.settings."com/github/flxzt/rnote" = {
    document-config-preset = builtins.toJSON {
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
}
