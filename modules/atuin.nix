self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.atuin = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.atuin;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = false;
      update_check = false;
      search_mode = "skim";
      inline_height = 10;
      show_preview = true;
      show_help = false;
      exit_mode = "return-query";
    };
  };
}
