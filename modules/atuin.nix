self:
{
  ...
}:

{
  hm-gep.programs.atuin = {
    enable = true;
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
