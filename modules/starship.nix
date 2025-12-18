self:
{
  lib,
  pkgs,
  ...
}:

{
  hm-gep.programs.starship = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.starship;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$character"
      ];
      directory.style = "blue";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };
    };
  };
}
