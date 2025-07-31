{
  config,
  pkgs,
  ...
}:

{
  hm-gep.programs.git = {
    includes = [
      {
        condition = "gitdir:~/work/";
        path =
          config.age.secrets."work/gitconfig".path or (toString (pkgs.writeText "work/gitconfig-stub" ""));
      }
    ];
  };

  age.secrets = {
    "work/gitconfig".owner = config.users.users.gep.name;
  };
}
