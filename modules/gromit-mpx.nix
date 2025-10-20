self:
{
  lib,
  pkgs,
  ...
}:

{
  hm-gep.services.gromit-mpx = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.gromit-mpx;
    hotKey = null;
    tools =
      map
        (
          x:
          with lib;
          {
            device = mkDefault "default";
            type = mkDefault "pen";
            size = mkDefault 3;
          }
          // x
        )
        [
          {
            color = "red";
          }
          {
            color = "green";
            modifiers = [ "SHIFT" ];
          }
          {
            color = "blue";
            modifiers = [ "CONTROL" ];
          }
          {
            color = "red";
            arrowSize = 2;
            modifiers = [ "ALT" ];
          }
          {
            type = "eraser";
            size = 75;
            modifiers = [ "3" ];
          }
        ];
  };
}
