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
        "$username"
        "$hostname"
        "$directory"
        "$character"
      ];
      username = {
        format = "[$user]($style)";
        style_user = "yellow";
      };
      hostname = {
        ssh_only = true;
        format = "@[$hostname]($style) ";
        style = "yellow";
      };
      directory.style = "blue";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };
    };
  };
}
