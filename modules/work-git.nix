self:
{
  config,
  ...
}:

{
  sops.secrets = {
    "gep/work/gitconfig".owner = config.users.users.gep.name;
  };

  hm-gep.programs.git = {
    includes = [
      {
        condition = "gitdir:~/work/";
        path = config.secrets.gep.work.gitconfig;
      }
    ];
  };
}
