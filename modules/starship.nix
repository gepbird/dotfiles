self: { lib, ... }:

{
  hm.programs.starship = {
    enable = true;
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
